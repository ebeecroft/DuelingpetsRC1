class CreateFaqs < ActiveRecord::Migration[5.2]
  def change
    create_table :faqs do |t|
      t.string :goal
      t.text :prereqs
      t.text :steps
      t.datetime :created_on
      t.datetime :updated_on

      t.timestamps
    end
  end
end
