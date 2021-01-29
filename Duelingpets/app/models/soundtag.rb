class Soundtag < ApplicationRecord
   #Soundtag related
   belongs_to :sound, optional: true
end
