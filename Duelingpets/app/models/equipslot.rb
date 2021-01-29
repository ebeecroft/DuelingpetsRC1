class Equipslot < ApplicationRecord
   #Equipslots related
   belongs_to :equip, optional: true

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the equipslot information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}
end
