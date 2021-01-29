class CreateWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.text :message
      t.string :ogg
      t.string :mp3
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :treasury, default: 0
      t.integer :profit, default: 0
      t.integer :hoardpoints, default: 0
      t.integer :emeralds, default: 0
      t.boolean :store_open, default: false

      t.timestamps
    end
  end
end
