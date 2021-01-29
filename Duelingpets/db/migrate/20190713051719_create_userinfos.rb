class CreateUserinfos < ActiveRecord::Migration[5.2]
  def change
    create_table :userinfos do |t|
      t.string :avatar
      t.string :miniavatar
      t.string :mp3
      t.string :ogg
      t.boolean :nightvision, default: false
      t.boolean :music_on, default: false
      t.boolean :mute_on, default: false
      t.string :audiobrowser, default: "ogg"
      t.string :videobrowser, default: "ogv"
      t.boolean :militarytime, default: false
      t.integer :bookgroup_id
      t.text :info
      t.integer :user_id
      t.integer :daycolor_id
      t.integer :nightcolor_id
      t.boolean :admincontrols_on, default: false
      t.boolean :reviewercontrols_on, default: false
      t.boolean :keymastercontrols_on, default: false
      t.boolean :managercontrols_on, default: false

      t.timestamps
    end
  end
end
