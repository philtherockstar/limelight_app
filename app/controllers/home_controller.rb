class HomeController < ApplicationController

  def index

  end

  def find_bids
    duplicate_same_property=false
    duplicate_new_property=false
    duplicate_same_property=true if params[:bid_option] == 'duplicate_same_property'
    duplicate_new_property=true if params[:bid_option] == 'duplicate_new_property'
    # user came back and selected a bid
    if params[:bid]
      bid=params[:bid]
      bid = do_duplicate(bid,params[:bid_option]) if (duplicate_same_property or duplicate_new_property)
      redirect_to("/bids/step1/"+bid.to_s)
    else
      @property = Property.find(params[:property][:id])
      @bids = Bid.where("property_id = ?", params[:property][:id])
      if @bids.size == 1
        bid=@bids[0].id
        logger.info ("bid option is #{params[:bid_option]}")
        bid = do_duplicate(bid,params[:bid_option]) if (duplicate_same_property or duplicate_new_property)
        redirect_to("/bids/step1/"+bid.to_s)
      elsif @bids.size > 0
        #render :action => "index"
        render :index
      else
        redirect_to "/", :notice => "No bids for that address"
      end
    end
  end

  private
  def do_duplicate(bid_id,action)
    logger.info ("duplicate action is #{action}")
    new_prop=nil
    bid = Bid.find(bid_id)
    new_bid = Bid.new
    if action == "duplicate_new_property"
      logger.info("action is duplicate_new_property")
      Property.transaction do
        new_prop = Property.new
        new_prop.country_id = bid.property.country_id
        new_prop.state_id = bid.property.state_id
        new_prop.address = 'Put address here'
        new_prop.city = 'x'
        new_prop.business_id = current_user.business_id
        new_prop.save
        logger.info("#{new_prop.inspect}")
      end
      logger.info("my new prop id = #{new_prop.id}")
      new_bid.property_id = new_prop.id
    else
      new_bid.property_id = bid.property_id
    end
    Bid.transaction do
      # first save the new bid
      new_bid.save
      bid.bid_rooms.each do |br|
        new_br = BidRoom.new
        new_br.bid_id = new_bid.id
        new_br.room_id = br.room_id
        new_br.num_rooms = br.num_rooms
        new_br.price = br.price
        new_br.save
        br.bid_room_items.each do |bri|
           new_bri = BidRoomItem.new
           new_bri.bid_id = new_bid.id
           new_bri.bid_room_id = new_br.id
           new_bri.room_id = bri.room_id
           new_bri.room_instance = bri.room_instance
           new_bri.room_name = bri.room_name
           new_bri.item_id = bri.item_id
           new_bri.item_name = bri.item_name
           new_bri.item_qty = bri.item_qty
           new_bri.rental_price = bri.rental_price
           new_bri.save
        end
      end
      bid.clients.each do |bc|
        new_bid.clients << bc
      end
      bid.realtors.each do |bidr|
        new_bid.realtors << bidr
      end
    end

    new_bid.id
  end

end
