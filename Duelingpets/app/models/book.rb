class Book < ApplicationRecord
   #Books related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :bookworld, optional: true
   belongs_to :gviewer, optional: true
   has_many :chapters, :foreign_key => "book_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the book information upon submission
   validates :title, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :description, presence: true
end
