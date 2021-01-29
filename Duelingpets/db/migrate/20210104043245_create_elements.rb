class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.string :name
      t.text :description
      t.string :itemart
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.boolean :reviewed, default: false
      t.boolean :pointsreceived, default: false

      t.timestamps
    end
  end
end
