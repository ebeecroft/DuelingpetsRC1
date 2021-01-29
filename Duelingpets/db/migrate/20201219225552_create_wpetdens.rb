class CreateWpetdens < ActiveRecord::Migration[5.2]
  def change
    create_table :wpetdens do |t|
      t.string :name
      t.integer :warehouse_id
      t.integer :creature1_id
      t.integer :qty1, default: 0
      t.integer :tax1, default: 0
      t.integer :creature2_id
      t.integer :qty2, default: 0
      t.integer :tax2, default: 0
      t.integer :creature3_id
      t.integer :qty3, default: 0
      t.integer :tax3, default: 0
      t.integer :creature4_id
      t.integer :qty4, default: 0
      t.integer :tax4, default: 0
      t.integer :creature5_id
      t.integer :qty5, default: 0
      t.integer :tax5, default: 0
      t.integer :creature6_id
      t.integer :qty6, default: 0
      t.integer :tax6, default: 0
      t.integer :creature7_id
      t.integer :qty7, default: 0
      t.integer :tax7, default: 0
      t.integer :creature8_id
      t.integer :qty8, default: 0
      t.integer :tax8, default: 0
      t.integer :creature9_id
      t.integer :qty9, default: 0
      t.integer :tax9, default: 0
      t.integer :creature10_id
      t.integer :qty10, default: 0
      t.integer :tax10, default: 0
      t.integer :creature11_id
      t.integer :qty11, default: 0
      t.integer :tax11, default: 0
      t.integer :creature12_id
      t.integer :qty12, default: 0
      t.integer :tax12, default: 0
      t.integer :creature13_id
      t.integer :qty13, default: 0
      t.integer :tax13, default: 0
      t.integer :creature14_id
      t.integer :qty14, default: 0
      t.integer :tax14, default: 0
      t.integer :creature15_id
      t.integer :qty15, default: 0
      t.integer :tax15, default: 0
      t.integer :creature16_id
      t.integer :qty16, default: 0
      t.integer :tax16, default: 0

      t.timestamps
    end
  end
end
