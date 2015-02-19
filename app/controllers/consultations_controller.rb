class ConsultationsController < ApplicationController
  before_action :set_consultation, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @consultations = Consultation.all
    respond_with(@consultations)
  end

  def show
    respond_with(@consultation)
  end

  def new
    @consultation = Consultation.new
    respond_with(@consultation)
  end

  def edit
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.save
    respond_with(@consultation)
  end

  def update
    @consultation.update(consultation_params)
    respond_with(@consultation)
  end

  def destroy
    @consultation.destroy
    respond_with(@consultation)
  end

  private
    def set_consultation
      @consultation = Consultation.find(params[:id])
    end

    def consultation_params
      params[:consultation]
    end
end
