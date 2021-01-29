class Pm < ApplicationRecord
   #PMs related
   belongs_to :user, optional: true
   belongs_to :pmbox, optional: true
   has_many :pmreplies, :foreign_key => "pm_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :image, ImageUploader
   mount_uploader :ogv, OgvUploader
   mount_uploader :mp4, Mp4Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the pm information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :message, presence: true
end
