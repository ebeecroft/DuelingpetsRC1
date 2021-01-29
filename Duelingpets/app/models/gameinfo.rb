class Gameinfo < ApplicationRecord
   #Gameinfo related
   belongs_to :user, optional: true
   belongs_to :difficulty, optional: true
end
