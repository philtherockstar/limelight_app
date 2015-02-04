class PropertyController < ApplicationController

  def search
    if params[:term]
      @properties = Property.where('business_id = ? and lower(address) LIKE ?', current_user.business_id, "%#{params[:term].downcase}%")
    elsif params[:address]
      @properties = Property.where("business_id = ? and lower(address) = ? and city = ? and state_id = ?", 
                                    current_user.business_id, 
                                    "#{params[:address].downcase}", 
                                    "#{params[:city]}",
                                    params[:state_id] )
    end


     
     respond_to do |format|  
       format.html # index.html.erb  
       format.json { render :json => @properties.to_json }
     end
     #render :json => @items.to_json
  end

end
