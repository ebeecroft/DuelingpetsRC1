class Equip < ApplicationRecord
   #Equip related
   has_many :equipslots, :foreign_key => "equip_id", :dependent => :destroy
   belongs_to :partner, optional: true
end
