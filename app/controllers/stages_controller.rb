class StagesController < ApplicationController
  before_action :set_stage, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @stages = Stage.all.order('stage_date desc')
    respond_with(@stages)
  end

  def show
    respond_with(@stage)
  end

  def new
    @stage = Stage.new
    respond_with(@stage)
  end

  def edit
  end

  def create
    @stage = Stage.new(stage_params)
    @stage.save
    respond_with(@stage)
  end

  def update
    @stage.update(stage_params)
    if params[:stage]['destage_date(1i)'].to_i > 0
      logger.info("destage_date =  #{params[:stage]['destage_date(1i)']}")
      property = Property.where("id = ?",@stage.property_id).first
      property.status_id = Status.where("status = 'De-Staged'").first.id
      property.save
    elsif Date.new(params[:stage]['stage_date(1i)'].to_i, params[:stage]['stage_date(2i)'].to_i, params[:stage]['stage_date(3i)'].to_i) <= Date.today
      property = Property.where("id = ?",@stage.property_id).first
      property.status_id = Status.where("status = 'Staged'").first.id
      property.save      
    end
    respond_with(@stage)
  end

  def destroy
    @stage.destroy
    respond_with(@stage)
  end

  private
    def set_stage
      @stage = Stage.find(params[:id])
    end

    def stage_params
      params[:stage].permit(:id, :rent, :total, :destage_date, :stage_date, :total, :monthly_rental, :stage)
    end
end
