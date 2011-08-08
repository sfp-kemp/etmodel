class ConstraintsController < ApplicationController
  def show    
    @constraint = Constraint.find(params[:id])
  end
  
  def iframe
    @api_client = Api::Client.new
    api_key = Current.setting.api_session_key rescue nil
  
    # be sure we're using the current session id
    # The client is smart enough to fetch a fresh session_id if missing
    @api_client.api_session_id = api_key
    
    @constraint = Constraint.find(params[:id])
    @constraint_id = params[:id]
    
    render :layout => 'constraint_iframe'
  end  
end
