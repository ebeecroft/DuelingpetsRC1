class Blogtype < ApplicationRecord
   #Blogtype
   has_many :blogs, :foreign_key => "blogtype_id", :dependent => :destroy
end
