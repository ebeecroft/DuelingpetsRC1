class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :imaginaryfriend
      t.string :email
      t.string :country
      t.string :country_timezone
      t.date :birthday
      t.string :login_id
      t.string :vname
      t.boolean :shared, default: false
      t.datetime :joined_on
      t.datetime :registered_on
      t.string :password_digest

      t.timestamps
    end
  end
end
