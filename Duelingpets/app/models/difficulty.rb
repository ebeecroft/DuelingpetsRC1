class Difficulty < ApplicationRecord
   #Difficulty related
   has_many :gameinfos

   #Regex information for difficulty
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the difficulty information upon submission
   validates :pointdebt, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :pointloan, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeralddebt, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldloan, presence: true, format: { with: VALID_VALUE_REGEX}
end
