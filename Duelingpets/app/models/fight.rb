class Fight < ApplicationRecord
   #Fight related
   belongs_to :partner, optional: true
   has_many :monsterbattles, :foreign_key => "fight_id", :dependent => :destroy
end
