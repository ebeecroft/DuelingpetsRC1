class Suggestion < ApplicationRecord
   #Suggestions related
   belongs_to :user, optional: true

   #Regex for suggestions
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the suggestion information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
end
