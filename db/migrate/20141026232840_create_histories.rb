class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :tagline
      t.text :body
      t.date :opt_timestamp

      t.timestamps
    end
  end
end
