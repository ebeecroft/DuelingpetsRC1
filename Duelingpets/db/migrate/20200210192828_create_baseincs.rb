class CreateBaseincs < ActiveRecord::Migration[5.2]
  def change
    create_table :baseincs do |t|
      t.string :name
      t.integer :amount
      t.datetime :created_on

      t.timestamps
    end
  end
end
