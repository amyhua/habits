class History < ActiveRecord::Base
	default_scope -> { order('created_at DESC')}

	validates_uniqueness_of :tag
end
