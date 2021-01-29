class Subplaylist < ApplicationRecord
   #Subplaylists related
   belongs_to :user, optional: true
   belongs_to :mainplaylist, optional: true
   has_many :movies, :foreign_key => "subplaylist_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the subplaylist information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
