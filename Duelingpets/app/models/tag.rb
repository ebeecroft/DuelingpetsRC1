class Tag < ApplicationRecord
   #Tags related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the tag information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
