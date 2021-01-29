class CreatePms < ActiveRecord::Migration[5.2]
  def change
    create_table :pms do |t|
      t.string :title
      t.text :message
      t.string :image
      t.string :ogg
      t.string :mp3
      t.string :ogv
      t.string :mp4
      t.datetime :created_on
      t.datetime :updated_on
      t.boolean :user1_unread, default: false
      t.boolean :user2_unread, default: false
      t.integer :user_id
      t.integer :pmbox_id

      t.timestamps
    end
  end
end
