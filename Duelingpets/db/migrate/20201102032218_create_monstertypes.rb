class CreateMonstertypes < ActiveRecord::Migration[5.2]
  def change
    create_table :monstertypes do |t|
      t.string :name
      t.datetime :created_on
      t.integer :basecost
      t.integer :emeraldcost

      t.timestamps
    end
  end
end
