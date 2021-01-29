class Artpage < ApplicationRecord
   #Uploader section
   mount_uploader :art, ArtUploader

   #Regex information for artpage
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validation section
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :message, presence: true
end
