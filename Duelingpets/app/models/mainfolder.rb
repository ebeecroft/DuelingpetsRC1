class Mainfolder < ApplicationRecord
   #Mainfolders related
   belongs_to :user, optional: true
   belongs_to :gallery, optional: true
   has_many :subfolders, :foreign_key => "mainfolder_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the mainfolder information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
