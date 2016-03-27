class CheckinSerializer < ActiveModel::Serializer 
	attributes :id, :sober, :remarks, :need_support, :user_id, :created_at, :updated_at, :user_image_url

	def user_image_url
		object.user.avatar.url
	end

end