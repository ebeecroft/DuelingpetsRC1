class Blogviewer < ApplicationRecord
   #Blogs
   has_many :blogs, :foreign_key => "blogviewer_id", :dependent => :destroy
end
