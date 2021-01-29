class CreateEquips < ActiveRecord::Migration[5.2]
  def change
    create_table :equips do |t|
      t.integer :capacity, default: 3
      t.integer :partner_id

      t.timestamps
    end
  end
end
