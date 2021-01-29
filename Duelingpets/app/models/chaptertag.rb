class Chaptertag < ApplicationRecord
   #Chaptertag related
   belongs_to :chapter, optional: true
end
