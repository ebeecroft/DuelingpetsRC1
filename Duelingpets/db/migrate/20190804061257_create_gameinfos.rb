class CreateGameinfos < ActiveRecord::Migration[5.2]
  def change
    create_table :gameinfos do |t|
      t.integer :difficulty_id
      t.boolean :lives_enabled, default: false
      t.boolean :ageing_enabled, default: false
      t.datetime :activated_on
      t.boolean :startgame, default: false
      t.boolean :gamecompleted, default: false
      t.integer :success, default: 0
      t.integer :failure, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
