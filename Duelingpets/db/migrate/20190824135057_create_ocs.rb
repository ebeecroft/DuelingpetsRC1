class CreateOcs < ActiveRecord::Migration[5.2]
  def change
    create_table :ocs do |t|
      t.string :name
      t.text :description
      t.string :nickname
      t.string :species
      t.integer :age
      t.text :personality
      t.text :likesanddislikes
      t.text :backgroundandhistory
      t.text :relatives
      t.text :family
      t.text :friends
      t.text :world
      t.string :alignment
      t.text :alliance
      t.text :elements
      t.text :appearance
      t.text :clothing
      t.text :accessories
      t.string :image
      t.string :ogg
      t.string :mp3
      t.string :voiceogg
      t.string :voicemp3
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.boolean :reviewed, default: false
      t.boolean :pointsreceived, default: false
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :gviewer_id

      t.timestamps
    end
  end
end
