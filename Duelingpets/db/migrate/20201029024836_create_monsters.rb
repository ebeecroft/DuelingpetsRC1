class CreateMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :monsters do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :ogg
      t.string :mp3
      t.integer :level, default: 0
      t.integer :hp, default: 0
      t.integer :atk, default: 0
      t.integer :def, default: 0
      t.integer :agility, default: 0
      t.integer :mp, default: 0
      t.integer :matk, default: 0
      t.integer :mdef, default: 0
      t.integer :magi, default: 0
      t.integer :exp, default: 0
      t.integer :loot, default: 0
      t.string :mischief
      t.integer :rarity, default: 1
      t.boolean :retiredmonster, default: false
      t.integer :cost, default: 0
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :monstertype_id
      t.integer :element_id
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
