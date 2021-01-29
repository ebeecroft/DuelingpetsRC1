class CreateUserupgrades < ActiveRecord::Migration[5.2]
  def change
    create_table :userupgrades do |t|
      t.string :name
      t.integer :base
      t.integer :baseinc
      t.integer :price
      t.integer :freecap
      t.integer :membercap

      t.timestamps
    end
  end
end
