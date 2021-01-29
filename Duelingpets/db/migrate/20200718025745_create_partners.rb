class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.text :description
      t.integer :plevel
      t.integer :pexp, default: 0
      t.integer :chp
      t.integer :hp
      t.integer :atk
      t.integer :def
      t.integer :agility
      t.integer :strength
      t.integer :mlevel
      t.integer :mexp, default: 0
      t.integer :cmp
      t.integer :mp
      t.integer :matk
      t.integer :mdef
      t.integer :magi
      t.integer :mstr
      t.integer :chunger
      t.integer :hunger
      t.integer :cthirst
      t.integer :thirst
      t.integer :cfun
      t.integer :fun
      t.integer :lives
      t.integer :adoptcost
      t.integer :cost
      t.integer :phytokens, default: 0
      t.integer :magitokens, default: 0
      t.datetime :adopted_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :creature_id
      t.boolean :activepet, default: false
      t.boolean :inbattle, default: false
      t.boolean :dead, default: false

      t.timestamps
    end
  end
end
