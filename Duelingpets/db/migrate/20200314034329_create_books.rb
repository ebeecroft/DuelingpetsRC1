class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :bookworld_id
      t.integer :gviewer_id
      t.boolean :collab_mode, default: false

      t.timestamps
    end
  end
end
