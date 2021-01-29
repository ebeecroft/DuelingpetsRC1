class CreateSubsheets < ActiveRecord::Migration[5.2]
  def change
    create_table :subsheets do |t|
      t.string :title
      t.text :description
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :mainsheet_id
      t.boolean :collab_mode, default: false
      t.boolean :fave_folder, default: false
      t.boolean :privatesubsheet, default: false

      t.timestamps
    end
  end
end
