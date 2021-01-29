class CreateEquipslots < ActiveRecord::Migration[5.2]
  def change
    create_table :equipslots do |t|
      t.string :name
      t.integer :equip_id
      t.integer :item1_id
      t.integer :curdur1, default: 0
      t.integer :startdur1, default: 0
      t.integer :item2_id
      t.integer :curdur2, default: 0
      t.integer :startdur2, default: 0
      t.integer :item3_id
      t.integer :curdur3, default: 0
      t.integer :startdur3, default: 0
      t.integer :item4_id
      t.integer :curdur4, default: 0
      t.integer :startdur4, default: 0
      t.integer :item5_id
      t.integer :curdur5, default: 0
      t.integer :startdur5, default: 0
      t.integer :item6_id
      t.integer :curdur6, default: 0
      t.integer :startdur6, default: 0
      t.integer :item7_id
      t.integer :curdur7, default: 0
      t.integer :startdur7, default: 0
      t.integer :item8_id
      t.integer :curdur8, default: 0
      t.integer :startdur8, default: 0
      t.boolean :activeslot, default: false

      t.timestamps
    end
  end
end
