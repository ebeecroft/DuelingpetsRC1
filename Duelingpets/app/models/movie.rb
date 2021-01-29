class Movie < ApplicationRecord
   #Movies related
   belongs_to :user, optional: true
   belongs_to :subplaylist, optional: true
   belongs_to :bookgroup, optional: true
   has_one :movietag, :foreign_key => "movie_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogv, OgvUploader
   mount_uploader :mp4, Mp4Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the movie information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
