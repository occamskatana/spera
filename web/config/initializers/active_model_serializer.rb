ActiveSupport.on_load(:active_mode_serializers) do 
	ActiveModel::Serializer.root = false
	ActiveModel::ArraySerializer.root = false
	ActiveRecord::Base.include_root_in_json = false
end