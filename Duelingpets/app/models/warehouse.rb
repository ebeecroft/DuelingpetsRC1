class Warehouse < ApplicationRecord
   #Pages that require warehouses
   has_many :witemshelves, :foreign_key => "warehouse_id", :dependent => :destroy
   has_many :wpetdens, :foreign_key => "warehouse_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex information for warehouse
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validation section
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :message, presence: true

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
