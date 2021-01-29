class CreateSuspendedtimelimits < ActiveRecord::Migration[5.2]
  def change
    create_table :suspendedtimelimits do |t|
      t.integer :pointfines, default: 0
      t.integer :emeraldfines, default: 0
      t.datetime :timelimit
      t.text :reason
      t.datetime :created_on
      t.integer :user_id
      t.integer :from_user_id

      t.timestamps
    end
  end
end
