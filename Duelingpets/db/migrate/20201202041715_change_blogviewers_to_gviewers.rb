class ChangeBlogviewersToGviewers < ActiveRecord::Migration[5.2]
  def change
     rename_table :blogviewers, :gviewers
  end
end
