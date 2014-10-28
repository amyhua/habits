class AddTaglineToHistories < ActiveRecord::Migration
  def change
  	add_column :histories, :tagline, :string
  end
end
