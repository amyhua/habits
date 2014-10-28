class AddTagdayToHistories < ActiveRecord::Migration
  def change
  	add_column :histories, :tagday, :string
  end
end
