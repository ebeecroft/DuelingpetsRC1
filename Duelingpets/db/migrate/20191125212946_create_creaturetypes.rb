class CreateCreaturetypes < ActiveRecord::Migration[5.2]
  def change
    create_table :creaturetypes do |t|
      t.string :name
      t.datetime :created_on
      t.integer :basehp
      t.integer :baseatk
      t.integer :basedef
      t.integer :baseagi
      t.integer :basestr
      t.integer :basehunger
      t.integer :basethirst
      t.integer :basefun
      t.integer :basecost
      t.integer :dreyterriumcost

      t.timestamps
    end
  end
end
