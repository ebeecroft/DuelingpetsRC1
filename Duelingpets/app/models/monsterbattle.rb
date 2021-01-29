class Monsterbattle < ApplicationRecord
   #Monsterbattles related
   belongs_to :monster, optional: true
   belongs_to :fight, optional: true
end
