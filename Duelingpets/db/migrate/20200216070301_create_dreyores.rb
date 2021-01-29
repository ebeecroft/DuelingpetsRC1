class CreateDreyores < ActiveRecord::Migration[5.2]
  def change
    create_table :dreyores do |t|
      t.string :name
      t.integer :cur, default: 0
      t.integer :cap
      t.integer :baseinc
      t.integer :change
      t.integer :price
      t.integer :extracted, default: 0
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :dragonhoard_id

      t.timestamps
    end
  end
end
