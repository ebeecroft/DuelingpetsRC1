class CreatePmreplies < ActiveRecord::Migration[5.2]
  def change
    create_table :pmreplies do |t|
      t.text :message
      t.string :image
      t.string :ogg
      t.string :mp3
      t.string :ogv
      t.string :mp4
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.integer :pm_id

      t.timestamps
    end
  end
end
