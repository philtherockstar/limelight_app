class HomeController < ApplicationController

  def index

  end

  def find_bids
    duplicate_same_property=false
    duplicate_new_property=false
    duplicate_same_property=true if params[:bid_options] == 'duplicate_same_property'
    duplicate_new_property=true if params[:bid_options] == 'duplicate_new_property'
    # user came back and selected a bid
    if params[:bid]
      bid=params[:bid]
      bid = do_duplicate_same_property(bid) if duplicate_same_property
      bid = do_duplicate_new_property(bid) if duplicate_new_property
      redirect_to("/bids/step1/"+bid.to_s)
    else
      @property = Property.find(params[:property][:id])
      @bids = Bid.where("property_id = ?", params[:property][:id])
      if @bids.size == 1
        bid=@bids[0].id
        bid = do_duplicate_same_property(bid) if duplicate_same_property
        bid = do_duplicate_new_property(bid) if duplicate_new_property
        redirect_to("/bids/step1/"+bid.to_s)
      elsif @bids.size > 0
        #render :action => "index"
        render :index
      else
        redirect_to "/", :notice => "No bids for that address"
      end
    end
  end

  private
  def do_duplicate_same_property(bid_id)
    # create a new bid for this property
    # insert into bid_rooms and bid_room_items, bid_clients and bid_realtors
    # for bid rooms, for each room, 
    #                1) insert the new room
    #                2) get the bid_room_items and for each, insert the new item based on the new bid_room_id
    #                3) create property and updaet bid.property_id
    #                4) insert clients
    #                5) insert realtors
  end
  def do_duplicate_new_property(bid_id)
    # create a new bid but leave property_id null
    # insert into bid_rooms and bid_room_items only
  end

end
