class Inventoryslot < ApplicationRecord
   #Inventoryslots related
   belongs_to :inventory, optional: true

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the inventoryslot information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}
end
