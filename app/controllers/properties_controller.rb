class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @properties = Property.all.order("ID desc")
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
    @cities=['']
    business.business_cities.each {|bc| @cities << bc.city }
  end

  def search
    if params[:term]
      @properties = Property.where('business_id = ? and lower(address) LIKE ?', current_user.business_id, "%#{params[:term].downcase}%")
    elsif params[:address]
      @properties = Property.where("business_id = ? and lower(address) = ? and city = ? and state_id = ?", 
                                    current_user.business_id, 
                                    "#{params[:address].downcase}", 
                                    "#{params[:city]}",
                                    params[:state_id] )
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
      end
      respond_with(@property)
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
      params.require(:property).permit(:address, :city, :state_id, :country_id, :business_id, :status_id, :sqft, :listing_price, :selling_price, :id, :est_closing_date)
    end
end
