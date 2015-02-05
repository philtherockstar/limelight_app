class PricingProposalController < ApplicationController

  layout 'pricing_proposal'
  def index
  	@bid = Bid.find(params[:id])
    @bid_rooms = BidRoom.where("bid_id = #{@bid.id}").order('display_order')
  end

end
