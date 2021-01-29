class Sound < ApplicationRecord
   #Sounds related
   belongs_to :user, optional: true
   belongs_to :subsheet, optional: true
   belongs_to :bookgroup, optional: true
   has_one :soundtag, :foreign_key => "sound_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the sound information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
