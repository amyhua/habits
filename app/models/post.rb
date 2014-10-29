class Post < ActiveRecord::Base
	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks
	
	default_scope -> { order('created_at DESC')}
	
end
