class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.integer :win, default: 0
      t.integer :draw, default: 0
      t.integer :loss, default: 0
      t.integer :partner_id

      t.timestamps
    end
  end
end
