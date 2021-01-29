class CreateDifficulties < ActiveRecord::Migration[5.2]
  def change
    create_table :difficulties do |t|
      t.string :name
      t.integer :pointdebt, default: 0
      t.integer :pointloan, default: 0
      t.integer :emeralddebt, default: 0
      t.integer :emeraldloan, default: 0
      t.datetime :created_on

      t.timestamps
    end
  end
end
