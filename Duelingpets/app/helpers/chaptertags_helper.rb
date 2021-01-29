module ChaptertagsHelper

   private
      def getChaptertagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ChaptertagId")
            value = params[:chaptertag_id]
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getTagname(tagid)
         tag = Tag.find_by_id(tagid)
         return tag.name
      end
      
      def tagCommons(type)
         logged_in = current_user
         chaptertagFound = Chaptertag.find_by_id(getChaptertagParams("ChaptertagId"))
         if(chaptertagFound && logged_in)
            if(type == "addtag")
               tagFound = Tag.find_by_name(params[:chaptertag][:name])
               slotFound = params[:chaptertag][:tagslot]
               if(tagFound && !slotFound.nil? && logged_in.id == chaptertagFound.chapter.user_id)
                  errorFlag = false
                  #Determines if the tag is already in the chaptertag list
                  tagset1 = (((chaptertagFound.tag1_id != tagFound.id && chaptertagFound.tag2_id != tagFound.id) && (chaptertagFound.tag3_id != tagFound.id && chaptertagFound.tag4_id != tagFound.id)) && ((chaptertagFound.tag5_id != tagFound.id && chaptertagFound.tag6_id != tagFound.id) && (chaptertagFound.tag7_id != tagFound.id && chaptertagFound.tag8_id != tagFound.id)))
                  tagset2 = (((chaptertagFound.tag9_id != tagFound.id && chaptertagFound.tag10_id != tagFound.id) && (chaptertagFound.tag11_id != tagFound.id && chaptertagFound.tag12_id != tagFound.id)) && ((chaptertagFound.tag13_id != tagFound.id && chaptertagFound.tag14_id != tagFound.id) && (chaptertagFound.tag15_id != tagFound.id && chaptertagFound.tag16_id != tagFound.id)))
                  tagset3 = ((chaptertagFound.tag17_id != tagFound.id && chaptertagFound.tag18_id != tagFound.id) && (chaptertagFound.tag19_id != tagFound.id && chaptertagFound.tag20_id != tagFound.id))
                  
                  #Checks if the tag is found
                  if(tagset1 && tagset2 && tagset3)
                     if(slotFound.to_i == 1)
                        chaptertagFound.tag1_id = tagFound.id
                     elsif(slotFound.to_i == 2)
                        chaptertagFound.tag2_id = tagFound.id
                     elsif(slotFound.to_i == 3)
                        chaptertagFound.tag3_id = tagFound.id
                     elsif(slotFound.to_i == 4)
                        chaptertagFound.tag4_id = tagFound.id
                     elsif(slotFound.to_i == 5)
                        chaptertagFound.tag5_id = tagFound.id
                     elsif(slotFound.to_i == 6)
                        chaptertagFound.tag6_id = tagFound.id
                     elsif(slotFound.to_i == 7)
                        chaptertagFound.tag7_id = tagFound.id
                     elsif(slotFound.to_i == 8)
                        chaptertagFound.tag8_id = tagFound.id
                     elsif(slotFound.to_i == 9)
                        chaptertagFound.tag9_id = tagFound.id
                     elsif(slotFound.to_i == 10)
                        chaptertagFound.tag10_id = tagFound.id
                     elsif(slotFound.to_i == 11)
                        chaptertagFound.tag11_id = tagFound.id
                     elsif(slotFound.to_i == 12)
                        chaptertagFound.tag12_id = tagFound.id
                     elsif(slotFound.to_i == 13)
                        chaptertagFound.tag13_id = tagFound.id
                     elsif(slotFound.to_i == 14)
                        chaptertagFound.tag14_id = tagFound.id
                     elsif(slotFound.to_i == 15)
                        chaptertagFound.tag15_id = tagFound.id
                     elsif(slotFound.to_i == 16)
                        chaptertagFound.tag16_id = tagFound.id
                     elsif(slotFound.to_i == 17)
                        chaptertagFound.tag17_id = tagFound.id
                     elsif(slotFound.to_i == 18)
                        chaptertagFound.tag18_id = tagFound.id
                     elsif(slotFound.to_i == 19)
                        chaptertagFound.tag19_id = tagFound.id
                     elsif(slotFound.to_i == 20)
                        chaptertagFound.tag20_id = tagFound.id
                     else
                        errorFlag = true
                     end
                     if(!errorFlag)
                        @chaptertag = chaptertagFound
                        @chaptertag.save
                        flash[:success] = "Tag #{tagFound.name} was added to the list!"
                        redirect_to book_chapter_path(@chaptertag.chapter.book, @chaptertag.chapter)
                     else
                        flash[:error] = "Invalid slot detected!"
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Tag #{tagFound.name} already exists in this list!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "removetag")
               errorFlag = false
               tagFound = Tag.find_by_id(params[:tagid])
               if(tagFound)
                  if(logged_in.pouch.privilege == "Admin" || logged_in.id == chaptertagFound.chapter.user_id)
                     tag = tagFound.id
                     if(chaptertagFound.tag1_id == tag)
                        chaptertagFound.tag1_id = nil
                     elsif(chaptertagFound.tag2_id == tag)
                        chaptertagFound.tag2_id = nil
                     elsif(chaptertagFound.tag3_id == tag)
                        chaptertagFound.tag3_id = nil
                     elsif(chaptertagFound.tag4_id == tag)
                        chaptertagFound.tag4_id = nil
                     elsif(chaptertagFound.tag5_id == tag)
                        chaptertagFound.tag5_id = nil
                     elsif(chaptertagFound.tag6_id == tag)
                        chaptertagFound.tag6_id = nil
                     elsif(chaptertagFound.tag7_id == tag)
                        chaptertagFound.tag7_id = nil
                     elsif(chaptertagFound.tag8_id == tag)
                        chaptertagFound.tag8_id = nil
                     elsif(chaptertagFound.tag9_id == tag)
                        chaptertagFound.tag9_id = nil
                     elsif(chaptertagFound.tag10_id == tag)
                        chaptertagFound.tag10_id = nil
                     elsif(chaptertagFound.tag11_id == tag)
                        chaptertagFound.tag11_id = nil
                     elsif(chaptertagFound.tag12_id == tag)
                        chaptertagFound.tag12_id = nil
                     elsif(chaptertagFound.tag13_id == tag)
                        chaptertagFound.tag13_id = nil
                     elsif(chaptertagFound.tag14_id == tag)
                        chaptertagFound.tag14_id = nil
                     elsif(chaptertagFound.tag15_id == tag)
                        chaptertagFound.tag15_id = nil
                     elsif(chaptertagFound.tag16_id == tag)
                        chaptertagFound.tag16_id = nil
                     elsif(chaptertagFound.tag17_id == tag)
                        chaptertagFound.tag17_id = nil
                     elsif(chaptertagFound.tag18_id == tag)
                        chaptertagFound.tag18_id = nil
                     elsif(chaptertagFound.tag19_id == tag)
                        chaptertagFound.tag19_id = nil
                     elsif(chaptertagFound.tag20_id == tag)
                        chaptertagFound.tag20_id = nil
                     else
                        #This case should never happen!
                        errorFlag = true
                     end
                     if(!errorFlag)
                        if(chaptertagFound.tag1_id.nil? && chaptertagFound.tag2_id.nil? && chaptertagFound.tag3_id.nil? && chaptertagFound.tag4_id.nil? && chaptertagFound.tag5_id.nil? && chaptertagFound.tag6_id.nil? && chaptertagFound.tag7_id.nil? && chaptertagFound.tag8_id.nil? && chaptertagFound.tag9_id.nil? && chaptertagFound.tag10_id.nil? && chaptertagFound.tag11_id.nil? && chaptertagFound.tag12_id.nil? && chaptertagFound.tag13_id.nil? && chaptertagFound.tag14_id.nil? && chaptertagFound.tag15_id.nil? && chaptertagFound.tag16_id.nil? && chaptertagFound.tag17_id.nil? && chaptertagFound.tag18_id.nil? && chaptertagFound.tag19_id.nil? && chaptertagFound.tag20_id.nil?)
                           chaptertagFound.tag1_id = 1
                        end
                        @chaptertag = chaptertagFound
                        @chaptertag.save
                        flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to chaptertags_path
                        else
                           redirect_to book_chapter_path(@chaptertag.chapter.book, @chaptertag.chapter)
                        end
                     else
                        flash[:error] = "This tag does not exist!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  flash[:error] = "Tagid is empty!"
                  redirect_to root_path
               end
            end
         else
            redirect_to root_path
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allChaptertags = Chaptertag.all
                  @chaptertags = Kaminari.paginate_array(allChaptertags).page(getChaptertagParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "addtag" || type == "removetag")
               if(current_user && current_user.pouch.privilege == "Admin")
                  tagCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     tagCommons(type)
                  end
               end
            end
         end
      end
end
