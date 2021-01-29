class Fieldcost < ApplicationRecord
   #Fieldcosts related
   belongs_to :baseinc, optional: true
   belongs_to :dragonhoard, optional: true

   #Regex for fieldcosts
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the fieldcost information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :amount, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :econtype, presence: true, format: {with: VALID_NAME_REGEX}
end
