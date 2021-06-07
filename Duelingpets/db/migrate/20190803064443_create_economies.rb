class CreateEconomies < ActiveRecord::Migration[5.2]
  def change
    create_table :economies do |t|
      t.string :name
      t.string :econtype
      t.string :content_type
      t.integer :amount
      t.string :currency
      t.datetime :created_on
      t.integer :user_id
      t.integer :dragonhoard_id

      t.timestamps
    end
  end
end
