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
    @cities=['']
    business.business_cities.each {|bc| @cities << bc.city }
    respond_with(@consultation)
  end

  def edit
    @consultation = Consultation.where("id = ?",params[:id].to_i).first
    @cities=['']
    business.business_cities.each {|bc| @cities << bc.city }
  end

  def create
    #@consultation = Consultation.new(consultation_params)
    #@consultation.save
    #respond_with(@consultation)
    @client=nil
    @realtor=nil
    @property=nil
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
        Consultation.transaction do
          if params[:consultation][:id]
            @consultation = Consultation.find(params[:consultation][:id])
          else
            @consultation = Consultation.new
          end
          @consultation.minutes = params['consultation']['minutes']
          @consultation.fee = params['consultation']['fee']
          @consultation.consultation_date = Date.new(params[:consultation]['consultation_date(1i)'].to_i,params[:consultation]['consultation_date(2i)'].to_i,params[:consultation]['consultation_date(3i)'].to_i)
          @consultation.property_id = @property.id
          if params['client']['first_name'].size > 0 || params['client']['last_name'].size > 0
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
              @consultation.client_id = @client.id        
            end
          end
          if params['realtor']['first_name'].size > 0 || params['realtor']['last_name'].size > 0
            Realtor.transaction do
              if params['realtor']['id'].to_i > 0
                @realtor = Realtor.find(params['realtor']['id'])
              else
                @realtor = Realtor.new
              end
              @realtor.first_name = params['realtor']['first_name']
              @realtor.last_name = params['realtor']['last_name']
              @realtor.phone = params['realtor']['phone']
              @realtor.email = params['realtor']['email']
              @realtor.business_id = current_user.business_id
              @realtor.save
              @consultation.realtor_id = @realtor.id 
            end
          end          

          begin
            @consultation.save
          rescue ActiveRecord::RecordNotUnique => e
            if e.message.match(/consultations_realtors|consultations_clients/)
              logger.info('consultations_realtors')
            end
          end
        end
      end
      redirect_to("/consultations/"+@consultation.id.to_s)
      #respond_with(@property, location => home_path(:step2 => '') )
    rescue Exception => e
      
      logger.fatal('Could not create a property and consultation')
      logger.fatal(e.message)
      redirect_to "/consultations", alert: 'Effin crap! Something went wrong. Call Phil!'
      #render action: 'new'
    end

  end

  def update
    @property=nil
    @client=nil
    @realtor=nil
    
    begin

      Property.transaction do
        
        #logger.info('property_id=' + params['property']['id'])
        if params['property']['id'].to_i > 0 
          @property = Property.where("id = ?",params['property']['id'].to_i).first
          #logger.info('prop addr from db is ' + @property.address)
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
        Consultation.transaction do
          @consultation = Consultation.where("id = ?",params[:consultation][:id].to_i).first
          @consultation.minutes = params['consultation']['minutes']
          @consultation.fee = params['consultation']['fee']
          @consultation.consultation_date = Date.new(params[:consultation]['consultation_date(1i)'].to_i,params[:consultation]['consultation_date(2i)'].to_i,params[:consultation]['consultation_date(3i)'].to_i)
          @consultation.property_id = @property.id

          if params['client']['first_name'].size > 0 || params['client']['last_name'].size > 0
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
              @consultation.client_id = @client.id 
            end
          end
          if params['realtor']['first_name'].size > 0 || params['realtor']['last_name'].size > 0
            Realtor.transaction do
              if params['realtor']['id'].to_i > 0
                @realtor = Realtor.find(params['realtor']['id'])
              else
                @realtor = Realtor.new
              end
              @realtor.first_name = params['realtor']['first_name']
              @realtor.last_name = params['realtor']['last_name']
              @realtor.phone = params['realtor']['phone']
              @realtor.email = params['realtor']['email']
              @realtor.business_id = current_user.business_id
              @realtor.save
              @consultation.realtor_id = @realtor.id
            end
          end                 
          @consultation.save
        end
      end
    rescue Exception => e
      
      logger.fatal('Could not create a property and consultation')
      logger.fatal(e.message)
      redirect_to "/consultations/edit", alert: 'Effin crap! Something went wrong. Call Phil!'
      #render action: 'new'
    end  


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
      params[:consultation].permit(:consultation_date,:minutes,:fee)
      params[:property].permit(:id,:state_id,:country_id,:address,:city,:sqft)
      params[:client].permit(:id,:first_name,:last_name,:phone,:email)
      params[:realtor].permit(:id,:first_name,:last_name,:phone,:email)
    end
end
