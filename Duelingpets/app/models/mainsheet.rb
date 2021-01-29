class Mainsheet < ApplicationRecord
   #Mainsheets related
   belongs_to :user, optional: true
   belongs_to :jukebox, optional: true
   has_many :subsheets, :foreign_key => "mainsheet_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the mainsheet information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
