class CreateMaintenancemodes < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenancemodes do |t|
      t.string :name
      t.datetime :created_on
      t.boolean :maintenance_on, default: false

      t.timestamps
    end
  end
end
