class Donor < ApplicationRecord
   #Donors related
   belongs_to :user, optional: true
   belongs_to :donationbox, optional: true

   #Regex for value
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the donationbox information upon submission
   validates :amount, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :description, presence: true
end
