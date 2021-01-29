class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.integer :capacity, default: 60
      t.integer :petcapacity, default: 80
      t.integer :user_id

      t.timestamps
    end
  end
end
