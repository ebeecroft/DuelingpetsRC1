class CreateBookworlds < ActiveRecord::Migration[5.2]
  def change
    create_table :bookworlds do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.boolean :open_world, default: false
      t.boolean :privateworld, default: false

      t.timestamps
    end
  end
end
