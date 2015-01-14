class ItemController < ApplicationController
  # FIX! at some point, we should add business_id to the Item model as business will want to set their own prices
  def index
    if params[:term]
       @items = Item.where('lower(name) LIKE ?', "%#{params[:term].downcase}%")
     else
       @items = Item.all
     end

     #respond_to do |format|  
     #  format.html # index.html.erb  
     #  format.json { render :json => @items.to_json }
     #end
     render :json => @items.to_json
  end
end
