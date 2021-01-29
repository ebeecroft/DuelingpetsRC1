class CreateCreaturetypes < ActiveRecord::Migration[5.2]
  def change
    create_table :creaturetypes do |t|
      t.string :name
      t.datetime :created_on
      t.integer :basecost
      t.integer :dreyterriumcost

      t.timestamps
    end
  end
end
