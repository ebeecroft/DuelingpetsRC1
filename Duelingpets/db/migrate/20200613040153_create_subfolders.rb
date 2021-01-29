class CreateSubfolders < ActiveRecord::Migration[5.2]
  def change
    create_table :subfolders do |t|
      t.string :title
      t.text :description
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :mainfolder_id
      t.boolean :collab_mode, default: false
      t.boolean :fave_folder, default: false
      t.boolean :privatesubfolder, default: false

      t.timestamps
    end
  end
end
