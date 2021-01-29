class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.string :ogg
      t.string :mp3
      t.string :adbanner
      t.string :admascot
      t.string :largeimage1
      t.string :largeimage2
      t.string :largeimage3
      t.string :smallimage1
      t.string :smallimage2
      t.string :smallimage3
      t.string :smallimage4
      t.string :smallimage5
      t.datetime :created_on
      t.datetime :reviewed_on
      t.datetime :updated_on
      t.integer :blogtype_id
      t.integer :bookgroup_id
      t.integer :gviewer_id
      t.integer :user_id
      t.boolean :box_open, default: false
      t.boolean :largeimage1purchased, default: false
      t.boolean :largeimage2purchased, default: false
      t.boolean :largeimage3purchased, default: false
      t.boolean :smallimage1purchased, default: false
      t.boolean :smallimage2purchased, default: false
      t.boolean :smallimage3purchased, default: false
      t.boolean :smallimage4purchased, default: false
      t.boolean :smallimage5purchased, default: false
      t.boolean :musicpurchased, default: false
      t.boolean :adbannerpurchased, default: false
      t.boolean :pointsreceived, default: false
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
