class CreateDonors < ActiveRecord::Migration[5.2]
  def change
    create_table :donors do |t|
      t.text :description
      t.integer :amount, default: 0
      t.integer :capacity, default: 50000
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :donationbox_id
      t.boolean :pointsreceived, default: false

      t.timestamps
    end
  end
end
