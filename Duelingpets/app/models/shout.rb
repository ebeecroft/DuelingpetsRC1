class Shout < ApplicationRecord
   #Validates shouts
   belongs_to :shoutbox
   belongs_to :user
   validates :message, presence: true
end
