class Baserate < ApplicationRecord
   #Pages that require baserates
   has_many :ratecosts, :foreign_key => "baserate_id", :dependent => :destroy
end
