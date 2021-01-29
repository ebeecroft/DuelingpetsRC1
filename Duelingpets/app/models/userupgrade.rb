class Userupgrade < ApplicationRecord
   #Regex information for userupgrade
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the userupgrade information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :base, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :baseinc, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :price, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :freecap, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :membercap, presence: true, format: { with: VALID_VALUE_REGEX}
end
