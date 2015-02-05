class RealtorController < ApplicationController

  def search
    if params[:term]
       @realtors = Realtor.where('business_id = ? and lower(first_name) LIKE ?', current_user.business_id, "%#{params[:term].downcase}%")
     else
       @realtors = Realtor.all
     end

     respond_to do |format|  
       format.html # index.html.erb  
       format.json { render :json => @realtors.to_json }
     end
     #render :json => @items.to_json
  end

end
