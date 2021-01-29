class CreateItemtypes < ActiveRecord::Migration[5.2]
  def change
    create_table :itemtypes do |t|
      t.string :name
      t.datetime :created_on
      t.integer :basecost
      t.integer :dreyterriumcost
      t.boolean :demoitem, default: false

      t.timestamps
    end
  end
end
