class Gallery < ApplicationRecord
   #Galleries related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :gviewer, optional: true
   has_many :mainfolders, :foreign_key => "gallery_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the gallery information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
