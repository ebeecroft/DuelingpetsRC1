class CreateRatecosts < ActiveRecord::Migration[5.2]
  def change
    create_table :ratecosts do |t|
      t.string :name
      t.float :amount, limit: 53
      t.string :econtype
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :baserate_id
      t.integer :dragonhoard_id

      t.timestamps
    end
  end
end
