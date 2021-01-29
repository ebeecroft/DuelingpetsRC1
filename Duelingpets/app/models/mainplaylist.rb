class Mainplaylist < ApplicationRecord
   #Mainplaylists related
   belongs_to :user, optional: true
   belongs_to :channel, optional: true
   has_many :subplaylists, :foreign_key => "mainplaylist_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the mainsheet information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
