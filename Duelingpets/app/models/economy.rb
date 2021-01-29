class Economy < ApplicationRecord
   #Economy related
   belongs_to :user, optional: true

   #Regex for name and amount
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_AMOUNT_REGEX = /\A[-]?[0-9!]+\z/i

   #Validates the economy information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}
   validates :econtype, presence: true, format: {with: VALID_NAME_REGEX}
   validates :content_type, presence: true, format: {with: VALID_NAME_REGEX}
   validates :amount, presence: true, format: {with: VALID_AMOUNT_REGEX}
end
