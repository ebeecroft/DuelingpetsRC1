class Channel < ApplicationRecord
   #Channels related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :gviewer, optional: true
   has_many :mainplaylists, :foreign_key => "channel_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the channel information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
