class Bookworld < ApplicationRecord
   #Bookworlds related
   belongs_to :user, optional: true
   has_many :books, :foreign_key => "bookworld_id", :dependent => :destroy

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the bookworld information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   validates :price, presence: true, format: {with: VALID_VALUE_REGEX}

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
