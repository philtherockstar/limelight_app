class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def self.business
    Business.find(1)
  end
  def business
    @business =  Business.find(1)
  end
  
end
