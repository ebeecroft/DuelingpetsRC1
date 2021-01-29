class Chapter < ApplicationRecord
   #Chapters related
   belongs_to :user, optional: true
   belongs_to :book, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :gchapter, optional: true
   has_one :chaptertag, :foreign_key => "chapter_id", :dependent => :destroy

   #Uploader section
   mount_uploader :voice1ogg, Voice1oggUploader
   mount_uploader :voice1mp3, Voice1mp3Uploader
   mount_uploader :voice2ogg, Voice2oggUploader
   mount_uploader :voice2mp3, Voice2mp3Uploader
   mount_uploader :voice3ogg, Voice3oggUploader
   mount_uploader :voice3mp3, Voice3mp3Uploader
   mount_uploader :bookcover, BookcoverUploader
   mount_uploader :storyscene1, Storyscene1Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the chapter information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :story, presence: true
end
