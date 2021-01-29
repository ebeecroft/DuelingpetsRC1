class Gchapter < ApplicationRecord
   #Gchapters related
   has_many :chapters, :foreign_key => "gchapter_id", :dependent => :destroy
end
