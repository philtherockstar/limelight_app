class HomeController < ApplicationController

  def index

  end

  def find_bids
    if params[:bid]
      redirect_to("/bids/step1/"+params[:bid])
    else
      @property = Property.find(params[:property][:id])
      @bids = Bid.where("property_id = ?", params[:property][:id])
      if @bids.size == 1
        redirect_to("/bids/step1/"+@bids[0].id.to_s)
      elsif @bids.size > 0
        #render :action => "index"
        render :index
      else
        redirect_to "/", :notice => "No bids for that address"
      end
    end
  end

end
