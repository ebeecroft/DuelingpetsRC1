class CreateBlogreplies < ActiveRecord::Migration[5.2]
  def change
    create_table :blogreplies do |t|
      t.text :message
      t.datetime :created_on
      t.datetime :updated_on
      t.datetime :reviewed_on
      t.integer :user_id
      t.integer :blog_id
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
