class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    step1
#    @bids = Bid.all
#    respond_with(@bids)
  end

  def show
    respond_with(@bid)
  end

  def new
    redirect_to :action => 'step1'
  #  @bid = Bid.new
  #  respond_with(@bid)
  end

  def edit
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.save
    respond_with(@bid)
  end

  def update
    @bid.update(bid_params)
    respond_with(@bid)
  end

  def destroy
    @bid.destroy
    respond_with(@bid)
  end

  def step1 
    if params[:id] # bid_id
      #@property = Property.new
      @bid = Bid.find(params[:id])
    else
      @bid = Bid.new
    end
    @cities=['']
    business.business_cities.each {|bc| @cities << bc.city }
  end

  def step1proc
    @property=nil
    @client=nil
    @realtor=nil
    begin
      Property.transaction do
        
        logger.info('property_id=' + params['property']['id'])
        if params['property']['id'].to_i > 0 
          @property = Property.find(params['property']['id'])
          logger.info('prop addr from db is ' + @property.address)
        else
          @property = Property.new
          logger.info('new property')
        end
        @property.address = params['property']['address']
        @property.city = params['property']['city']
        @property.sqft = params['property']['sqft']
        @property.state_id = params['property']['state_id']
        @property.country_id = params['property']['country_id']
        @property.business_id = current_user.business_id
        @property.save
        Bid.transaction do
          if params[:bid]
            @bid = Bid.find(params[:bid][:id])
          else
            @bid = Bid.new
          end
          @bid.property_id = @property.id
          Client.transaction do
            if params['client']['id'].to_i > 0
              @client = Client.find(params['client']['id'])
            else
              @client = Client.new
            end
            @client.first_name = params['client']['first_name']
            @client.last_name = params['client']['last_name']
            @client.phone = params['client']['phone']
            @client.email = params['client']['email']
            @client.business_id = current_user.business_id
            @client.save
          end
          Realtor.transaction do
            if params['realtor']['id'].to_i > 0
              @realtor = Realtor.find(params['realtor']['id'])
            elsif @bid.realtors.size > 0
              @realtor = @bid.realtors[0]
            else
              @realtor = Realtor.new
            end
            @realtor.first_name = params['realtor']['first_name']
            @realtor.last_name = params['realtor']['last_name']
            @realtor.phone = params['realtor']['phone']
            @realtor.email = params['realtor']['email']
            @realtor.business_id = current_user.business_id
            @realtor.save
          end
          @bid.clients << @client
          @bid.realtors << @realtor
          @bid.save
        end
      end
      redirect_to("/bids/step2/"+@bid.id.to_s)
      #respond_with(@property, location => home_path(:step2 => '') )
    rescue Exception => e
      
      logger.fatal('Could not create a property and bid')
      logger.fatal(e.message)
      redirect_to "/bids/step1", alert: 'Could not save to the databases. Maybe not all the required fields were entered?'
      #render action: 'new'
    end
  end

  def step2 
    @bid = Bid.find(params[:id])
    @bid_rooms = BidRoom.where("bid_id = #{@bid.id}")
    @rooms = Room.find_by_sql("SELECT r.*, rp.price FROM rooms AS r LEFT JOIN room_prices AS rp ON rp.room_id = r.id AND rp.business_id = #{current_user.business_id}")
    @bid_rooms_total=0
    @bid_rooms.each {|br| @bid_rooms_total += (br.price * br.num_rooms)}
  end

  def step2proc 
    rooms = params[:rooms]
    bid_id = params[:bid_id]
    #BidRoom.delete_all(["bid_id = ?", bid_id])
    staging_fee = 0
    ActiveRecord::Base.transaction do
      rooms.each do |room|
        if room[1].to_i > 0 
           br = BidRoom.where("bid_id = #{bid_id} and room_id = #{room[0]}").first_or_create
           br.bid_id = bid_id
           br.room_id = room[0]
           br.num_rooms = room[1]
           br.price = params[:room_prices][room[0]]
           br.save
           staging_fee += (br.price * br.num_rooms)
        else
          br = BidRoom.where("bid_id = #{bid_id} and room_id = #{room[0]}")
          if br.size > 0 
            BidRoom.destroy(br[0].id)
          end
        end     
      end
      bid = Bid.find(bid_id)      
      bid.staging_fee = staging_fee unless ( params.has_key?(:overwrite_staging_fee) && params[:overwrite_staging_fee] == "N" )
      logger.info ("NOTE: hardcoding distro fee and rental weeks. we should get distribution_fee and weeks_included from a preferences table")
      bid.distribution_fee = 250
      bid.weeks_included = 6 
      bid.save
    end
    redirect_to :action => 'step3', :id => bid_id
  end

  def step3 
    @bid = Bid.find(params[:id])
    @bid_rooms = BidRoom.where("bid_id = #{@bid.id}")
    @bid_room_items = BidRoomItem.all.where( "bid_id = #{@bid.id}")
  end

  def step3proc 
    bid_id = params[:bid_id]
    quantities = params[:bid_rooms_item_quantity]
    total_rental=0
    ActiveRecord::Base.transaction do
      BidRoomItem.delete_all(["bid_id = ?", bid_id])
      quantities.each do |bid_room_id, instance|
        instance.each do |instance_num, bid_room_qty_hash|
          bid_room_qty_hash.each do |item_id, qty|
            if qty.to_i > 0
              bri = BidRoomItem.new
              bri.bid_id = bid_id
              bri.bid_room_id = bid_room_id
              bri.room_instance = instance_num
              bri.item_id = item_id
              bri.item_name = params[:bid_rooms_item][bid_room_id][instance_num][item_id]
              bri.item_qty = qty
              bri.rental_price = params[:bid_rooms_item_rental_price][bid_room_id][instance_num][item_id]
              bri.save
              total_rental += (bri.item_qty * bri.rental_price)
            end
          end
        end
      end
      bid = Bid.find(bid_id)
      bid.staging_fee = params[:bid][:staging_fee]
      bid.distribution_fee = params[:bid][:distribution_fee]
      bid.weeks_included = params[:bid][:weeks_included]
      bid.rental_monthly = total_rental
      bid.rental_weekly = total_rental/4
      bid.rental = (bid.rental_weekly * bid.weeks_included)
      bid.bid_date = Time.now.in_time_zone
      bid.save
    end
    logger.info("items_form_action=#{params[:items_form_action] }")
    if params[:items_form_action] == 'Save'
      flash[:notice] = 'Data successfully saved!'
      redirect_to :action => 'step3', :id => bid_id 
    else
      redirect_to :controller => 'pricing_proposal', :action => 'index', :id => bid_id
    end
    #render :text => "hello"
  end

  def step4 
    @bid = Bid.find(params[:id])
    @bid_rooms = BidRoom.where("bid_id = #{@bid.id}")
  end


  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:index)
    end
end
