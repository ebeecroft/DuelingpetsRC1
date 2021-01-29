class ApplicationController < ActionController::Base
   protect_from_forgery
   include CusersHelper
   include VisitorretrievalHelper
   include WordsHelper
end
