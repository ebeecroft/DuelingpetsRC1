class Inventory < ApplicationRecord
   #Inventory related
   has_many :inventoryslots, :foreign_key => "inventory_id", :dependent => :destroy
   belongs_to :user, optional: true
end
