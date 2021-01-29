module FaqsHelper

   private
      def getFaqParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Faq")
            value = params.require(:faq).permit(:goal, :prereqs, :steps)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               allFaqs = Faq.order("updated_on desc, created_on desc")
               @faqs = Kaminari.paginate_array(allFaqs).page(getFaqParams("Page")).per(10)
            elsif(type == "new" || type == "create")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  newFaq = Faq.new
                  if(type == "create")
                     newFaq = Faq.new(getFaqParams("Faq"))
                     newFaq.created_on = currentTime
                     newFaq.updated_on = currentTime
                  end
                  @faq = newFaq
                  if(type == "create")
                     if(@faq.save)
                        flash[:success] = "#{@faq.goal} was successfully created."
                        redirect_to user_faqs_path(@user)
                     else
                        render "new"
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               logged_in = current_user
               faqFound = Faq.find_by_id(getFaqParams("Id"))
               if(logged_in && logged_in.pouch.privilege == "Admin" && faqFound)
                  faqFound.reviewed = false
                  faqFound.updated_on = currentTime
                  @faq = faqFound
                  if(type == "update")
                     if(@faq.update_attributes(getFaqParams("Faq")))
                        flash[:success] = "Faq #{@faq.goal} was successfully updated."
                        redirect_to faqs_path
                     else
                        render "edit"
                     end
                  elsif(type == "destroy")
                     @faq.destroy
                     flash[:success] = "Faq #{@faq.name} was successfully removed."
                     redirect_to faqs_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
