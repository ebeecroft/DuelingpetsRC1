class CreateWebcontrols < ActiveRecord::Migration[5.2]
  def change
    create_table :webcontrols do |t|
      t.datetime :created_on
      t.string :banner
      t.string :mascot
      t.string :favicon
      t.integer :daycolor_id
      t.integer :nightcolor_id
      t.string :ogg
      t.string :mp3
      t.string :criticalogg
      t.string :criticalmp3
      t.string :betaogg
      t.string :betamp3
      t.string :grandogg
      t.string :grandmp3
      t.string :creationogg
      t.string :creationmp3
      t.string :maintenanceogg
      t.string :maintenancemp3
      t.string :missingpageogg
      t.string :missingpagemp3
      t.boolean :gate_open, default: false

      t.timestamps
    end
  end
end
