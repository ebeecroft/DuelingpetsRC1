class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :bookgroup_id
      t.integer :user_id

      t.timestamps
    end
  end
end
