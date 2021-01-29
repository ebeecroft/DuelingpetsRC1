class CreateInventoryslots < ActiveRecord::Migration[5.2]
  def change
    create_table :inventoryslots do |t|
      t.string :name
      t.integer :inventory_id
      t.integer :item1_id
      t.integer :curdur1, default: 0
      t.integer :startdur1, default: 0
      t.integer :qty1, default: 0
      t.integer :item2_id
      t.integer :curdur2, default: 0
      t.integer :startdur2, default: 0
      t.integer :qty2, default: 0
      t.integer :item3_id
      t.integer :curdur3, default: 0
      t.integer :startdur3, default: 0
      t.integer :qty3, default: 0
      t.integer :item4_id
      t.integer :curdur4, default: 0
      t.integer :startdur4, default: 0
      t.integer :qty4, default: 0
      t.integer :item5_id
      t.integer :curdur5, default: 0
      t.integer :startdur5, default: 0
      t.integer :qty5, default: 0
      t.integer :item6_id
      t.integer :curdur6, default: 0
      t.integer :startdur6, default: 0
      t.integer :qty6, default: 0
      t.integer :item7_id
      t.integer :curdur7, default: 0
      t.integer :startdur7, default: 0
      t.integer :qty7, default: 0
      t.integer :item8_id
      t.integer :curdur8, default: 0
      t.integer :startdur8, default: 0
      t.integer :qty8, default: 0
      t.integer :item9_id
      t.integer :curdur9, default: 0
      t.integer :startdur9, default: 0
      t.integer :qty9, default: 0
      t.integer :item10_id
      t.integer :curdur10, default: 0
      t.integer :startdur10, default: 0
      t.integer :qty10, default: 0
      t.integer :item11_id
      t.integer :curdur11, default: 0
      t.integer :startdur11, default: 0
      t.integer :qty11, default: 0
      t.integer :item12_id
      t.integer :curdur12, default: 0
      t.integer :startdur12, default: 0
      t.integer :qty12, default: 0
      t.integer :item13_id
      t.integer :curdur13, default: 0
      t.integer :startdur13, default: 0
      t.integer :qty13, default: 0
      t.integer :item14_id
      t.integer :curdur14, default: 0
      t.integer :startdur14, default: 0
      t.integer :qty14, default: 0

      t.timestamps
    end
  end
end
