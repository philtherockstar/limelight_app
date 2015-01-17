class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @properties = Property.all
    respond_with(@properties)
  end

  def show
    respond_with(@property)
  end

  def new
    @property = Property.new
    respond_with(@property)
  end

  def edit
  end

  def search
    if params[:term]
       @properties = Property.where('business_id = ? and lower(address) LIKE ?', current_user.business_id, "%#{params[:term].downcase}%")
     else
       @properties = Property.all
     end

     respond_to do |format|  
       format.html # index.html.erb  
       format.json { render :json => @properties.to_json }
     end
     #render :json => @items.to_json
  end

  def create
    begin
      Property.transaction do
        @property = Property.new(property_params)
        @property.save
        Bid.transaction do
          @bid = Bid.new
          @bid.property_id = @property.id
          @bid.save
        end
      end
      redirect_to("/bids/step2/"+@bid.id.to_s)
      #respond_with(@property, location => home_path(:step2 => '') )
    rescue
      logger.fatal('Could not create a property and bid')
      redirect_to "/bids/step1", notice: 'Not all the required fields were entered'
      #render action: 'new'
    end
  end

  def update
    @property.update(property_params)
    respond_with(@property)
  end

  def destroy
    @property.destroy
    respond_with(@property)
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:address, :city, :state_id, :country_id, :business_id)
    end
end
