class RealtorsController < ApplicationController
  before_action :set_realtor, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @realtors = Realtor.all
    respond_with(@realtors)
  end

  def show
    respond_with(@realtor)
  end

  def new
    @realtor = Realtor.new
    respond_with(@realtor)
  end

  def edit
  end


  def create
    @realtor = Realtor.new(realtor_params)
    @realtor.save
    respond_with(@realtor)
  end

  def update
    @realtor.update(realtor_params)
    respond_with(@realtor)
  end

  def destroy
    @realtor.destroy
    respond_with(@realtor)
  end

  private
    def set_realtor
      @realtor = Realtor.find(params[:id])
    end

    def realtor_params
      params.require(:realtor).permit(:first_name, :last_name, :company, :phone, :email, :created_at, :updated_at)
    end
end
