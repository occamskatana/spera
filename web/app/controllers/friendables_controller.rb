class FriendablesController < ApplicationController

  def friend_request
  	from_id = current_user.id 
  	to_id = params[:id] 
  	friendable = Friendable.create(from_id: from_id, to_id: to_id, accepted: false)
  end

  def friend_request_accept
  	friendable = Friendable.where(to_id: current_user.id, from_id: params[:id]).first 
  	friendable.update_attributes(accepted: true)
  end

  def friend_request_reject
  	friendable = Friendable.where(to_id: current_user.id, from_id: params[:id]).first 
  	friendable.destroy
  end

end
