class Bookgroup < ApplicationRecord
   #Pages that require bookgroups
   has_many :userinfos, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :blogs, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :ocs, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :jukeboxes, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :sounds, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :books, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :chapters, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :galleries, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :arts, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :channels, :foreign_key => "bookgroup_id", :dependent => :destroy
   has_many :movies, :foreign_key => "bookgroup_id", :dependent => :destroy
end
