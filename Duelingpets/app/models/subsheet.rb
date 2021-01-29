class Subsheet < ApplicationRecord
   #Subsheets related
   belongs_to :user, optional: true
   belongs_to :mainsheet, optional: true
   has_many :sounds, :foreign_key => "subsheet_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the subsheet information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
