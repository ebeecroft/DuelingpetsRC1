class Blog < ApplicationRecord
   #Blogs related
   has_many :blogreplies, :foreign_key => "blog_id", :dependent => :destroy
   #has_many :blogstars, :foreign_key => "blog_id", :dependent => :destroy
   #has_many :blogvisits, :foreign_key => "blog_id", :dependent => :destroy
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :blogtype, optional: true
   belongs_to :gviewer, optional: true

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :adbanner, AdbannerUploader
   mount_uploader :admascot, AdmascotUploader
   mount_uploader :largeimage1, Largeimage1Uploader
   mount_uploader :largeimage2, Largeimage2Uploader
   mount_uploader :largeimage3, Largeimage3Uploader
   mount_uploader :smallimage1, Smallimage1Uploader
   mount_uploader :smallimage2, Smallimage2Uploader
   mount_uploader :smallimage3, Smallimage3Uploader
   mount_uploader :smallimage4, Smallimage4Uploader
   mount_uploader :smallimage5, Smallimage5Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the blog information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
