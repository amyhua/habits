class AddMoodToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :mood, :integer
  	# on a scale of 1 (sad) to 10 (happy)
  end
end
