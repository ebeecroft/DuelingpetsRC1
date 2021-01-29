class CreateMonsterbattles < ActiveRecord::Migration[5.2]
  def change
    create_table :monsterbattles do |t|
      t.integer :partner_plevel
      t.integer :partner_pexp
      t.integer :partner_chp
      t.integer :partner_hp
      t.integer :partner_atk
      t.integer :partner_def
      t.integer :partner_agility
      t.integer :partner_strength
      t.integer :partner_mlevel
      t.integer :partner_mexp
      t.integer :partner_cmp
      t.integer :partner_mp
      t.integer :partner_matk
      t.integer :partner_mdef
      t.integer :partner_magi
      t.integer :partner_mstr
      t.integer :partner_lives
      t.integer :partner_damage, default: 0
      t.boolean :partner_activepet, default: false
      t.integer :creaturetype_id
      t.string :monster_mischief
      t.integer :monster_plevel
      t.integer :monster_chp
      t.integer :monster_hp
      t.integer :monster_atk
      t.integer :monster_def
      t.integer :monster_agility
      t.integer :monster_mlevel
      t.integer :monster_cmp
      t.integer :monster_mp
      t.integer :monster_matk
      t.integer :monster_mdef
      t.integer :monster_magi
      t.integer :monster_loot
      t.integer :monster_damage, default: 0
      t.integer :monstertype_id
      t.integer :round, default: 1
      t.integer :tokens_earned, default: 0
      t.integer :exp_earned, default: 0
      t.integer :dreyore_earned, default: 0
      t.integer :items_earned, default: 0
      t.boolean :battleover, default: false
      t.string :battleresult, default: "Not-Started"
      t.datetime :started_on
      t.datetime :ended_on
      t.integer :fight_id
      t.integer :monster_id

      t.timestamps
    end
  end
end
