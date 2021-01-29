module OctagsHelper

   private
      def getOCTagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "OCTagId")
            value = params[:octag_id]
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
         octagFound = Octag.find_by_id(getOCTagParams("OCTagId"))
         if(octagFound && logged_in)
            if(type == "addtag")
               tagFound = Tag.find_by_name(params[:octag][:name])
               slotFound = params[:octag][:tagslot]
               if(tagFound && !slotFound.nil? && logged_in.id == octagFound.oc.user_id)
                  errorFlag = false
                  #Determines if the tag is already in the octag list
                  tagset1 = (((octagFound.tag1_id != tagFound.id && octagFound.tag2_id != tagFound.id) && (octagFound.tag3_id != tagFound.id && octagFound.tag4_id != tagFound.id)) && ((octagFound.tag5_id != tagFound.id && octagFound.tag6_id != tagFound.id) && (octagFound.tag7_id != tagFound.id && octagFound.tag8_id != tagFound.id)))
                  tagset2 = (((octagFound.tag9_id != tagFound.id && octagFound.tag10_id != tagFound.id) && (octagFound.tag11_id != tagFound.id && octagFound.tag12_id != tagFound.id)) && ((octagFound.tag13_id != tagFound.id && octagFound.tag14_id != tagFound.id) && (octagFound.tag15_id != tagFound.id && octagFound.tag16_id != tagFound.id)))
                  tagset3 = ((octagFound.tag17_id != tagFound.id && octagFound.tag18_id != tagFound.id) && (octagFound.tag19_id != tagFound.id && octagFound.tag20_id != tagFound.id))
                  
                  #Checks if the tag is found
                  if(tagset1 && tagset2 && tagset3)
                     if(slotFound.to_i == 1)
                        octagFound.tag1_id = tagFound.id
                     elsif(slotFound.to_i == 2)
                        octagFound.tag2_id = tagFound.id
                     elsif(slotFound.to_i == 3)
                        octagFound.tag3_id = tagFound.id
                     elsif(slotFound.to_i == 4)
                        octagFound.tag4_id = tagFound.id
                     elsif(slotFound.to_i == 5)
                        octagFound.tag5_id = tagFound.id
                     elsif(slotFound.to_i == 6)
                        octagFound.tag6_id = tagFound.id
                     elsif(slotFound.to_i == 7)
                        octagFound.tag7_id = tagFound.id
                     elsif(slotFound.to_i == 8)
                        octagFound.tag8_id = tagFound.id
                     elsif(slotFound.to_i == 9)
                        octagFound.tag9_id = tagFound.id
                     elsif(slotFound.to_i == 10)
                        octagFound.tag10_id = tagFound.id
                     elsif(slotFound.to_i == 11)
                        octagFound.tag11_id = tagFound.id
                     elsif(slotFound.to_i == 12)
                        octagFound.tag12_id = tagFound.id
                     elsif(slotFound.to_i == 13)
                        octagFound.tag13_id = tagFound.id
                     elsif(slotFound.to_i == 14)
                        octagFound.tag14_id = tagFound.id
                     elsif(slotFound.to_i == 15)
                        octagFound.tag15_id = tagFound.id
                     elsif(slotFound.to_i == 16)
                        octagFound.tag16_id = tagFound.id
                     elsif(slotFound.to_i == 17)
                        octagFound.tag17_id = tagFound.id
                     elsif(slotFound.to_i == 18)
                        octagFound.tag18_id = tagFound.id
                     elsif(slotFound.to_i == 19)
                        octagFound.tag19_id = tagFound.id
                     elsif(slotFound.to_i == 20)
                        octagFound.tag20_id = tagFound.id
                     else
                        errorFlag = true
                     end
                     if(!errorFlag)
                        @octag = octagFound
                        @octag.save
                        flash[:success] = "Tag #{tagFound.name} was added to the list!"
                        redirect_to user_oc_path(@octag.oc.user, @octag.oc)
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
                  if(logged_in.pouch.privilege == "Admin" || logged_in.id == octagFound.oc.user_id)
                     tag = tagFound.id
                     if(octagFound.tag1_id == tag)
                        octagFound.tag1_id = nil
                     elsif(octagFound.tag2_id == tag)
                        octagFound.tag2_id = nil
                     elsif(octagFound.tag3_id == tag)
                        octagFound.tag3_id = nil
                     elsif(octagFound.tag4_id == tag)
                        octagFound.tag4_id = nil
                     elsif(octagFound.tag5_id == tag)
                        octagFound.tag5_id = nil
                     elsif(octagFound.tag6_id == tag)
                        octagFound.tag6_id = nil
                     elsif(octagFound.tag7_id == tag)
                        octagFound.tag7_id = nil
                     elsif(octagFound.tag8_id == tag)
                        octagFound.tag8_id = nil
                     elsif(octagFound.tag9_id == tag)
                        octagFound.tag9_id = nil
                     elsif(octagFound.tag10_id == tag)
                        octagFound.tag10_id = nil
                     elsif(octagFound.tag11_id == tag)
                        octagFound.tag11_id = nil
                     elsif(octagFound.tag12_id == tag)
                        octagFound.tag12_id = nil
                     elsif(octagFound.tag13_id == tag)
                        octagFound.tag13_id = nil
                     elsif(octagFound.tag14_id == tag)
                        octagFound.tag14_id = nil
                     elsif(octagFound.tag15_id == tag)
                        octagFound.tag15_id = nil
                     elsif(octagFound.tag16_id == tag)
                        octagFound.tag16_id = nil
                     elsif(octagFound.tag17_id == tag)
                        octagFound.tag17_id = nil
                     elsif(octagFound.tag18_id == tag)
                        octagFound.tag18_id = nil
                     elsif(octagFound.tag19_id == tag)
                        octagFound.tag19_id = nil
                     elsif(octagFound.tag20_id == tag)
                        octagFound.tag20_id = nil
                     else
                        #This case should never happen!
                        errorFlag = true
                     end
                     if(!errorFlag)
                        if(octagFound.tag1_id.nil? && octagFound.tag2_id.nil? && octagFound.tag3_id.nil? && octagFound.tag4_id.nil? && octagFound.tag5_id.nil? && octagFound.tag6_id.nil? && octagFound.tag7_id.nil? && octagFound.tag8_id.nil? && octagFound.tag9_id.nil? && octagFound.tag10_id.nil? && octagFound.tag11_id.nil? && octagFound.tag12_id.nil? && octagFound.tag13_id.nil? && octagFound.tag14_id.nil? && octagFound.tag15_id.nil? && octagFound.tag16_id.nil? && octagFound.tag17_id.nil? && octagFound.tag18_id.nil? && octagFound.tag19_id.nil? && octagFound.tag20_id.nil?)
                           octagFound.tag1_id = 1
                        end
                        @octag = octagFound
                        @octag.save
                        flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to octags_path
                        else
                           redirect_to user_oc_path(@octag.oc.user, @octag.oc)
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
                  allOCtags = Octag.all
                  @octags = Kaminari.paginate_array(allOCtags).page(getOCTagParams("Page")).per(10)
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
