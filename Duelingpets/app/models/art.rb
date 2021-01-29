class Art < ApplicationRecord
   #Arts related
   belongs_to :user, optional: true
   belongs_to :subfolder, optional: true
   belongs_to :bookgroup, optional: true
   has_one :arttag, :foreign_key => "art_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :image, ImageUploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the art information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
