class Movietag < ApplicationRecord
   #Movietag related
   belongs_to :movie, optional: true
end
