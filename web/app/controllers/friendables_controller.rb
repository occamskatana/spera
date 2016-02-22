class FriendablesController < ApplicationController

  respond_to :json, :html
  

  def friend_request
  	from_id = current_user.id 
  	to_id = params[:id] 
  	friendable = Friendable.create(from_id: from_id, to_id: to_id, accepted: false)
  end

  def friend_request_accept
  	friendable = Friendable.where(id: params[:id]).first
  	
     friendable.update_attributes(accepted: true)
    
    respond_with friendable
    
  end

  def friend_request_reject
  	friendable = Friendable.where(id: params[:id]).first 
  	friendable.delete
    render json: {status: 200, message: "Success"}, status: 200
  end

 

end
