class Baseinc < ApplicationRecord
   #Pages that require baseincs
   has_many :fieldcosts, :foreign_key => "baseinc_id", :dependent => :destroy
end
