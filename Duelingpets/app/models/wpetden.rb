class Wpetden < ApplicationRecord
   #Wpetdens related
   belongs_to :warehouse, optional: true

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the wpetden information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
end
