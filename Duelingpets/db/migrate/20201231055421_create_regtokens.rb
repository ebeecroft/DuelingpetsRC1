class CreateRegtokens < ActiveRecord::Migration[5.2]
  def change
    create_table :regtokens do |t|
      t.string :token
      t.datetime :expiretime

      t.timestamps
    end
  end
end
