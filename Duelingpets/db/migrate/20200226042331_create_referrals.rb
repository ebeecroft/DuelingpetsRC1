class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.datetime :created_on
      t.integer :user_id
      t.integer :referred_by_id

      t.timestamps
    end
  end
end
