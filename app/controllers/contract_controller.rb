class ContractController < ApplicationController
  layout 'contract'

  def print
  	@contract = Contract.find(params[:id])
  end
  
end
