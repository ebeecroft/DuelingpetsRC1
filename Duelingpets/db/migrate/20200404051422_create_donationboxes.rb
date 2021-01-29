class CreateDonationboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :donationboxes do |t|
      t.text :description
      t.integer :progress
      t.integer :goal
      t.integer :capacity
      t.datetime :initialized_on
      t.integer :user_id
      t.boolean :hitgoal, default: false
      t.boolean :box_open, default: false

      t.timestamps
    end
  end
end
