class CreatePouches < ActiveRecord::Migration[5.2]
  def change
    create_table :pouches do |t|
      t.integer :user_id
      t.string :privilege, default: "User"
      t.boolean :admin, default: false
      t.boolean :demouser, default: false
      t.boolean :banned, default: false
      t.string :remember_token
      t.datetime :expiretime
      t.boolean :activated, default: false
      t.datetime :signed_in_at
      t.datetime :last_visited
      t.datetime :signed_out_at
      t.boolean :gone, default: false
      t.integer :amount, default: 0
      t.integer :emeraldamount, default: 0
      t.integer :dreyterriumamount, default: 0
      t.boolean :firstdreyterrium, default: false

      t.timestamps
    end
  end
end
