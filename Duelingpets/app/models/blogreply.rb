class Blogreply < ApplicationRecord
   #Validates blogreplies
   belongs_to :blog
   belongs_to :user
   validates :message, presence: true
end
