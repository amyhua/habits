class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :tag

      t.timestamps
    end
  end
end
