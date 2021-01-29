class CreateArts < ActiveRecord::Migration[5.2]
  def change
    create_table :arts do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :ogg
      t.string :mp3
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :subfolder_id
      t.boolean :reviewed, default: false
      t.boolean :pointsreceived, default: false

      t.timestamps
    end
  end
end
