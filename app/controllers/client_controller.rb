class ClientController < ApplicationController

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
  
end
