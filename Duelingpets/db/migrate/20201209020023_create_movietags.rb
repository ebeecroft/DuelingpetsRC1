class CreateMovietags < ActiveRecord::Migration[5.2]
  def change
    create_table :movietags do |t|
      t.integer :movie_id
      t.integer :tag1_id
      t.integer :tag2_id
      t.integer :tag3_id
      t.integer :tag4_id
      t.integer :tag5_id
      t.integer :tag6_id
      t.integer :tag7_id
      t.integer :tag8_id
      t.integer :tag9_id
      t.integer :tag10_id
      t.integer :tag11_id
      t.integer :tag12_id
      t.integer :tag13_id
      t.integer :tag14_id
      t.integer :tag15_id
      t.integer :tag16_id
      t.integer :tag17_id
      t.integer :tag18_id
      t.integer :tag19_id
      t.integer :tag20_id

      t.timestamps
    end
  end
end
