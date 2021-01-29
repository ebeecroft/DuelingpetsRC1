class Faq < ApplicationRecord
   #Regex for goal
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9! -]+\z/i

   #Validates the faq information upon submission
   validates :goal, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :prereqs, presence: true
   validates :steps, presence: true
end
