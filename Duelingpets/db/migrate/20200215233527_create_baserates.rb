class CreateBaserates < ActiveRecord::Migration[5.2]
  def change
    create_table :baserates do |t|
      t.string :name
      t.float :amount, limit: 53
      t.datetime :created_on

      t.timestamps
    end
  end
end
