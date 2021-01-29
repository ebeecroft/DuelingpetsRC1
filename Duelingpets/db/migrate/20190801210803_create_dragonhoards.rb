class CreateDragonhoards < ActiveRecord::Migration[5.2]
  def change
    create_table :dragonhoards do |t|
      t.string :name
      t.text :message
      t.datetime :created_on
      t.datetime :updated_on
      t.string :ogg
      t.string :mp3
      t.integer :basecost, default: 0
      t.float :baserate, limit: 53
      t.integer :treasury, default: 0
      t.integer :contestpoints, default: 0
      t.integer :profit, default: 0
      t.integer :warepoints, default: 0
      t.integer :helperpoints, default: 0
      t.integer :emeralds, default: 0
      t.string :dragonimage

      t.timestamps
    end
  end
end
