class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.string :ogg
      t.string :mp3
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :gviewer_id
      t.boolean :music_on, default: false
      t.boolean :privategallery, default: false

      t.timestamps
    end
  end
end
