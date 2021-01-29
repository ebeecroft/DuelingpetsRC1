class CreateMainsheets < ActiveRecord::Migration[5.2]
  def change
    create_table :mainsheets do |t|
      t.string :title
      t.text :description
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :jukebox_id

      t.timestamps
    end
  end
end
