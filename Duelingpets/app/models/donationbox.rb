class Donationbox < ApplicationRecord
   #Donationboxes related
   belongs_to :user, optional: true
   has_many :donors, :foreign_key => "donationbox_id", :dependent => :destroy

   #Regex for value
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the donationbox information upon submission
   #validates :goal, presence: true, format: {with: VALID_VALUE_REGEX}
   #validates :description, presence: true
end
