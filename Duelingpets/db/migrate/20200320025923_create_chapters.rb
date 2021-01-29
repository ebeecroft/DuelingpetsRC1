class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :story
      t.string :bookcover
      t.string :storyscene1
      t.string :voice1ogg
      t.string :voice1mp3
      t.string :voice2ogg
      t.string :voice2mp3
      t.string :voice3ogg
      t.string :voice3mp3
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :book_id
      t.integer :gchapter_id, default: 1
      t.boolean :reviewed, default: false
      t.boolean :pointsreceived, default: false

      t.timestamps
    end
  end
end
