class CreateBlacklisteddomains < ActiveRecord::Migration[5.2]
  def change
    create_table :blacklisteddomains do |t|
      t.string :name
      t.datetime :created_on
      t.boolean :domain_only, default: false

      t.timestamps
    end
  end
end
