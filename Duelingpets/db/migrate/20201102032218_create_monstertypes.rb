class CreateMonstertypes < ActiveRecord::Migration[5.2]
  def change
    create_table :monstertypes do |t|
      t.string :name
      t.datetime :created_on
      t.integer :basehp
      t.integer :baseatk
      t.integer :basedef
      t.integer :baseagi
      t.integer :baseexp
      t.integer :basenightmare
      t.integer :baseshinycraze
      t.integer :baseparty
      t.integer :basecost
      t.integer :emeraldcost

      t.timestamps
    end
  end
end
