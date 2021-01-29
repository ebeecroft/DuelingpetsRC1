class Gviewer < ApplicationRecord
   #Gviewer related
   has_many :blogs, :foreign_key => "gviewer_id", :dependent => :destroy
   has_many :channels, :foreign_key => "gviewer_id", :dependent => :destroy
   has_many :galleries, :foreign_key => "gviewer_id", :dependent => :destroy
   has_many :jukeboxes, :foreign_key => "gviewer_id", :dependent => :destroy
   has_many :books, :foreign_key => "gviewer_id", :dependent => :destroy
   has_many :ocs, :foreign_key => "gviewer_id", :dependent => :destroy
end
