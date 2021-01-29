class Subfolder < ApplicationRecord
   #Subfolders related
   belongs_to :user, optional: true
   belongs_to :mainfolder, optional: true
   has_many :arts, :foreign_key => "subfolder_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the subfolder information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
