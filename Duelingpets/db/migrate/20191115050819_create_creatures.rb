class CreateCreatures < ActiveRecord::Migration[5.2]
  def change
    create_table :creatures do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :activepet
      t.string :ogg
      t.string :mp3
      t.string :voiceogg
      t.string :voicemp3
      t.integer :level, default: 0
      t.integer :hp, default: 0
      t.integer :atk, default: 0
      t.integer :def, default: 0
      t.integer :agility, default: 0
      t.integer :strength, default: 0
      t.integer :mp, default: 0
      t.integer :matk, default: 0
      t.integer :mdef, default: 0
      t.integer :magi, default: 0
      t.integer :mstr, default: 0
      t.integer :hunger, default: 0
      t.integer :thirst, default: 0
      t.integer :fun, default: 0
      t.integer :lives, default: 0
      t.integer :rarity, default: 1
      t.boolean :unlimitedlives, default: false
      t.boolean :retiredpet, default: false
      t.boolean :starter, default: false
      t.integer :emeraldcost, default: 0
      t.integer :cost
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :creaturetype_id
      t.integer :element_id
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
