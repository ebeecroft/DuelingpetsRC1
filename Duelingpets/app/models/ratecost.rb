class Ratecost < ApplicationRecord
   #Ratecosts related
   belongs_to :baserate, optional: true
   belongs_to :dragonhoard, optional: true

   #Regex for ratecosts
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+[.][0-9]+\z/i

   #Validates the ratecost information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :amount, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :econtype, presence: true, format: {with: VALID_NAME_REGEX}
end
