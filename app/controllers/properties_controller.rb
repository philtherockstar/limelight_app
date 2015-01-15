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
      redirect_to("/home/step2/"+@bid.id.to_s)
      #respond_with(@property, location => home_path(:step2 => '') )
    rescue
      logger.fatal('Could not create a property and bid')
      redirect_to "/home/step1", notice: 'Not all the required fields were entered'
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
