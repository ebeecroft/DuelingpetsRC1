class CreateColorschemes < ActiveRecord::Migration[5.2]
  def change
    create_table :colorschemes do |t|
      t.string :name
      t.string :colortype
      t.text :description
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
      t.boolean :activated, default: false
      t.boolean :nightcolor, default: false
      t.boolean :democolor, default: false
      t.string :backgroundcolor, default: "#000000"
      t.string :headercolor, default: "#000000"
      t.string :subheader1color, default: "#000000"
      t.string :subheader2color, default: "#000000"
      t.string :subheader3color, default: "#000000"
      t.string :textcolor, default: "#000000"
      t.string :editbuttoncolor, default: "#000000"
      t.string :editbuttonbackgcolor, default: "#000000"
      t.string :destroybuttoncolor, default: "#000000"
      t.string :destroybuttonbackgcolor, default: "#000000"
      t.string :submitbuttoncolor, default: "#000000"
      t.string :submitbuttonbackgcolor, default: "#000000"
      t.string :navigationcolor, default: "#000000"
      t.string :navigationlinkcolor, default: "#000000"
      t.string :navigationhovercolor, default: "#000000"
      t.string :navigationhoverbackgcolor, default: "#000000"
      t.string :onlinestatuscolor, default: "#000000"
      t.string :profilecolor, default: "#000000"
      t.string :profilehovercolor, default: "#000000"
      t.string :profilehoverbackgcolor, default: "#000000"
      t.string :sessioncolor, default: "#000000"
      t.string :navlinkcolor, default: "#000000"
      t.string :navlinkhovercolor, default: "#000000"
      t.string :navlinkhoverbackgcolor, default: "#000000"
      t.string :explanationborder, default: "#000000"
      t.string :explanationbackgcolor, default: "#000000"
      t.string :explanheadercolor, default: "#000000"
      t.string :explantextcolor, default: "#000000"
      t.string :errorfieldcolor, default: "#000000"
      t.string :errorcolor, default: "#000000"
      t.string :warningcolor, default: "#000000"
      t.string :notificationcolor, default: "#000000"
      t.string :successcolor, default: "#000000"

      t.timestamps
    end
  end
end
