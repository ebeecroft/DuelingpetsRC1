class CreateWitemshelves < ActiveRecord::Migration[5.2]
  def change
    create_table :witemshelves do |t|
      t.string :name
      t.integer :warehouse_id
      t.integer :item1_id
      t.integer :qty1, default: 0
      t.integer :tax1, default: 0
      t.integer :item2_id
      t.integer :qty2, default: 0
      t.integer :tax2, default: 0
      t.integer :item3_id
      t.integer :qty3, default: 0
      t.integer :tax3, default: 0
      t.integer :item4_id
      t.integer :qty4, default: 0
      t.integer :tax4, default: 0
      t.integer :item5_id
      t.integer :qty5, default: 0
      t.integer :tax5, default: 0
      t.integer :item6_id
      t.integer :qty6, default: 0
      t.integer :tax6, default: 0
      t.integer :item7_id
      t.integer :qty7, default: 0
      t.integer :tax7, default: 0
      t.integer :item8_id
      t.integer :qty8, default: 0
      t.integer :tax8, default: 0
      t.integer :item9_id
      t.integer :qty9, default: 0
      t.integer :tax9, default: 0
      t.integer :item10_id
      t.integer :qty10, default: 0
      t.integer :tax10, default: 0
      t.integer :item11_id
      t.integer :qty11, default: 0
      t.integer :tax11, default: 0
      t.integer :item12_id
      t.integer :qty12, default: 0
      t.integer :tax12, default: 0
      t.integer :item13_id
      t.integer :qty13, default: 0
      t.integer :tax13, default: 0
      t.integer :item14_id
      t.integer :qty14, default: 0
      t.integer :tax14, default: 0
      t.integer :item15_id
      t.integer :qty15, default: 0
      t.integer :tax15, default: 0
      t.integer :item16_id
      t.integer :qty16, default: 0
      t.integer :tax16, default: 0
      t.integer :item17_id
      t.integer :qty17, default: 0
      t.integer :tax17, default: 0
      t.integer :item18_id
      t.integer :qty18, default: 0
      t.integer :tax18, default: 0
      t.integer :item19_id
      t.integer :qty19, default: 0
      t.integer :tax19, default: 0
      t.integer :item20_id
      t.integer :qty20, default: 0
      t.integer :tax20, default: 0
      t.integer :item21_id
      t.integer :qty21, default: 0
      t.integer :tax21, default: 0
      t.integer :item22_id
      t.integer :qty22, default: 0
      t.integer :tax22, default: 0
      t.integer :item23_id
      t.integer :qty23, default: 0
      t.integer :tax23, default: 0
      t.integer :item24_id
      t.integer :qty24, default: 0
      t.integer :tax24, default: 0
      t.integer :item25_id
      t.integer :qty25, default: 0
      t.integer :tax25, default: 0
      t.integer :item26_id
      t.integer :qty26, default: 0
      t.integer :tax26, default: 0
      t.integer :item27_id
      t.integer :qty27, default: 0
      t.integer :tax27, default: 0
      t.integer :item28_id
      t.integer :qty28, default: 0
      t.integer :tax28, default: 0
      t.integer :item29_id
      t.integer :qty29, default: 0
      t.integer :tax29, default: 0
      t.integer :item30_id
      t.integer :qty30, default: 0
      t.integer :tax30, default: 0

      t.timestamps
    end
  end
end
