class Pouch < ApplicationRecord
   #Pouch related
   belongs_to :user, optional: true
   has_one :pouchslot, :foreign_key => "pouch_id", :dependent => :destroy
end
