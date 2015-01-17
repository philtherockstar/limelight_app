class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @clients = Client.all
    respond_with(@clients)
  end

  def show
    respond_with(@client)
  end

  def new
    @client = Client.new
    respond_with(@client)
  end

  def edit
  end

  def search
    if params[:term]
       @clients = Client.where('business_id = ? and lower(first_name) LIKE ?', current_user.business_id, "%#{params[:term].downcase}%")
     else
       @clients = Client.all
     end

     respond_to do |format|  
       format.html # index.html.erb  
       format.json { render :json => @clients.to_json }
     end
     #render :json => @items.to_json
  end

  def create
    @client = Client.new(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :address, :phone, :email, :created_at, :updated_at)
    end
end
