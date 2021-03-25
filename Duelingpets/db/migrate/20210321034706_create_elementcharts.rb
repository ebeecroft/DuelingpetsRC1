class CreateElementcharts < ActiveRecord::Migration[5.2]
  def change
    create_table :elementcharts do |t|
      t.integer :sstrength_id
      t.integer :estrength_id
      t.integer :sweak_id
      t.integer :eweak_id
      t.integer :element_id

      t.timestamps
    end
  end
end
