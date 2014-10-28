class History < ActiveRecord::Base
	default_scope -> { order('created_at DESC')}
	scope :created_on, lambda {|date| {:conditions => ['created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day]}}

	validates_uniqueness_of :tag

	def self.today
		where("created_at BETWEEN '#{DateTime.now.beginning_of_day}' AND '#{DateTime.now.end_of_day}'")
	end
end
