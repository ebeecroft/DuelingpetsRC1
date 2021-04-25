class CreateFieldcosts < ActiveRecord::Migration[5.2]
  def change
    create_table :fieldcosts do |t|
      t.string :name
      t.integer :amount
      t.string :econtype
      t.string :pricetype
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :baseinc_id
      t.integer :dragonhoard_id

      t.timestamps
    end
  end
end
