class CreateSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :sounds do |t|
      t.string :title
      t.text :description
      t.string :ogg
      t.string :mp3
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :bookgroup_id
      t.integer :subsheet_id
      t.boolean :reviewed, default: false
      t.boolean :pointsreceived, default: false

      t.timestamps
    end
  end
end
