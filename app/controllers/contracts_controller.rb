class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  #layout 'contract'

  respond_to :html

  def index
    @contracts = Contract.all
    respond_with(@contracts)
  end

  def show
    respond_with(@contract)
  end

  def new
    @bid = Bid.find(params[:id])
    @contract = Contract.new
    @contract.bid_id = @bid.id
    @contract.property_id = @bid.property_id
    @client = @bid.clients.first
    @contract.client_id = @client.id
    @contract.legal_name = "#{@client.first_name} #{@client.last_name}"
    @contract.proposal_filename = "#{@bid.property.address} Pricing Proposal.pdf"
    @contract.proposal_mailed_to = @contract.legal_name
    room_str=''
    @bid.bid_rooms.each do |bdr| 
      room_str += "#{bdr.num_rooms.to_s} #{bdr.room.name}"
      room_str += "s" if bdr.num_rooms > 1
      room_str += ", "
    end
    room_str = room_str[0..-3]
    @contract.proposed_rooms = room_str
    @contract.staging_cost = @bid.bid_total
    @contract.weekly_rental = @bid.rental_weekly

    respond_with(@contract)
  end

  def print
  end

  def edit
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.save
    redirect_to "/contract/#{@contract.id}"
    #respond_with(@contract)
  end

  def update
    @contract.update(contract_params)
    respond_with(@contract)
  end

  def destroy
    @contract.destroy
    respond_with(@contract)
  end

  private
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def contract_params
      params[:contract].permit(:id,:bid_id,:property_id,:client_id,:legal_name,:proposal_filename,
                               :proposal_mailed_to,:proposal_mail_date,:proposed_rooms,:staging_date,
                               :nonmovable_items,:staging_cost,:included_rental,:weekly_rental,:commit)
    end
end
