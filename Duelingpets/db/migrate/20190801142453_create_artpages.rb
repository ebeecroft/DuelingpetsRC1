class CreateArtpages < ActiveRecord::Migration[5.2]
  def change
    create_table :artpages do |t|
      t.string :name
      t.text :message
      t.datetime :created_on
      t.string :art

      t.timestamps
    end
  end
end
