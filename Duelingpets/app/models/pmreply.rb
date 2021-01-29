class Pmreply < ApplicationRecord
   #PMreplies related
   belongs_to :user, optional: true
   belongs_to :pm, optional: true

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :image, ImageUploader
   mount_uploader :ogv, OgvUploader
   mount_uploader :mp4, Mp4Uploader

   #Validates the pmreply information upon submission
   validates :message, presence: true
end
