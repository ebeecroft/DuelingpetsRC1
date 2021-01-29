class Dreyore < ApplicationRecord
   #Dreyores related
   belongs_to :dragonhoard, optional: true

   #Regex for dreyores
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the dreyore information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}
   validates :change, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :cap, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :baseinc, presence: true, format: {with: VALID_VALUE_REGEX}
end
