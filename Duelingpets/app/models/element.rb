class Element < ApplicationRecord
   #Elements related
   belongs_to :user, optional: true
   #has_many :creatures, :foreign_key => "element_id", :dependent => :destroy
   #has_many :monsters, :foreign_key => "element_id", :dependent => :destroy

   #Uploader section
   mount_uploader :itemart, ItemartUploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the oc information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   
   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
