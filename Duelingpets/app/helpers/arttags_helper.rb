module ArttagsHelper

   private
      def getArttagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ArttagId")
            value = params[:arttag_id]
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
         arttagFound = Arttag.find_by_id(getArttagParams("ArttagId"))
         if(arttagFound && logged_in)
            if(type == "addtag")
               tagFound = Tag.find_by_name(params[:arttag][:name])
               slotFound = params[:arttag][:tagslot]
               if(tagFound && !slotFound.nil? && logged_in.id == arttagFound.art.user_id)
                  errorFlag = false
                  #Determines if the tag is already in the arttag list
                  tagset1 = (((arttagFound.tag1_id != tagFound.id && arttagFound.tag2_id != tagFound.id) && (arttagFound.tag3_id != tagFound.id && arttagFound.tag4_id != tagFound.id)) && ((arttagFound.tag5_id != tagFound.id && arttagFound.tag6_id != tagFound.id) && (arttagFound.tag7_id != tagFound.id && arttagFound.tag8_id != tagFound.id)))
                  tagset2 = (((arttagFound.tag9_id != tagFound.id && arttagFound.tag10_id != tagFound.id) && (arttagFound.tag11_id != tagFound.id && arttagFound.tag12_id != tagFound.id)) && ((arttagFound.tag13_id != tagFound.id && arttagFound.tag14_id != tagFound.id) && (arttagFound.tag15_id != tagFound.id && arttagFound.tag16_id != tagFound.id)))
                  tagset3 = ((arttagFound.tag17_id != tagFound.id && arttagFound.tag18_id != tagFound.id) && (arttagFound.tag19_id != tagFound.id && arttagFound.tag20_id != tagFound.id))
                  
                  #Checks if the tag is found
                  if(tagset1 && tagset2 && tagset3)
                     if(slotFound.to_i == 1)
                        arttagFound.tag1_id = tagFound.id
                     elsif(slotFound.to_i == 2)
                        arttagFound.tag2_id = tagFound.id
                     elsif(slotFound.to_i == 3)
                        arttagFound.tag3_id = tagFound.id
                     elsif(slotFound.to_i == 4)
                        arttagFound.tag4_id = tagFound.id
                     elsif(slotFound.to_i == 5)
                        arttagFound.tag5_id = tagFound.id
                     elsif(slotFound.to_i == 6)
                        arttagFound.tag6_id = tagFound.id
                     elsif(slotFound.to_i == 7)
                        arttagFound.tag7_id = tagFound.id
                     elsif(slotFound.to_i == 8)
                        arttagFound.tag8_id = tagFound.id
                     elsif(slotFound.to_i == 9)
                        arttagFound.tag9_id = tagFound.id
                     elsif(slotFound.to_i == 10)
                        arttagFound.tag10_id = tagFound.id
                     elsif(slotFound.to_i == 11)
                        arttagFound.tag11_id = tagFound.id
                     elsif(slotFound.to_i == 12)
                        arttagFound.tag12_id = tagFound.id
                     elsif(slotFound.to_i == 13)
                        arttagFound.tag13_id = tagFound.id
                     elsif(slotFound.to_i == 14)
                        arttagFound.tag14_id = tagFound.id
                     elsif(slotFound.to_i == 15)
                        arttagFound.tag15_id = tagFound.id
                     elsif(slotFound.to_i == 16)
                        arttagFound.tag16_id = tagFound.id
                     elsif(slotFound.to_i == 17)
                        arttagFound.tag17_id = tagFound.id
                     elsif(slotFound.to_i == 18)
                        arttagFound.tag18_id = tagFound.id
                     elsif(slotFound.to_i == 19)
                        arttagFound.tag19_id = tagFound.id
                     elsif(slotFound.to_i == 20)
                        arttagFound.tag20_id = tagFound.id
                     else
                        errorFlag = true
                     end
                     if(!errorFlag)
                        @arttag = arttagFound
                        @arttag.save
                        flash[:success] = "Tag #{tagFound.name} was added to the list!"
                        redirect_to subfolder_art_path(@arttag.art.subfolder, @arttag.art)
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
                  if(logged_in.pouch.privilege == "Admin" || logged_in.id == arttagFound.art.user_id)
                     tag = tagFound.id
                     if(arttagFound.tag1_id == tag)
                        arttagFound.tag1_id = nil
                     elsif(arttagFound.tag2_id == tag)
                        arttagFound.tag2_id = nil
                     elsif(arttagFound.tag3_id == tag)
                        arttagFound.tag3_id = nil
                     elsif(arttagFound.tag4_id == tag)
                        arttagFound.tag4_id = nil
                     elsif(arttagFound.tag5_id == tag)
                        arttagFound.tag5_id = nil
                     elsif(arttagFound.tag6_id == tag)
                        arttagFound.tag6_id = nil
                     elsif(arttagFound.tag7_id == tag)
                        arttagFound.tag7_id = nil
                     elsif(arttagFound.tag8_id == tag)
                        arttagFound.tag8_id = nil
                     elsif(arttagFound.tag9_id == tag)
                        arttagFound.tag9_id = nil
                     elsif(arttagFound.tag10_id == tag)
                        arttagFound.tag10_id = nil
                     elsif(arttagFound.tag11_id == tag)
                        arttagFound.tag11_id = nil
                     elsif(arttagFound.tag12_id == tag)
                        arttagFound.tag12_id = nil
                     elsif(arttagFound.tag13_id == tag)
                        arttagFound.tag13_id = nil
                     elsif(arttagFound.tag14_id == tag)
                        arttagFound.tag14_id = nil
                     elsif(arttagFound.tag15_id == tag)
                        arttagFound.tag15_id = nil
                     elsif(arttagFound.tag16_id == tag)
                        arttagFound.tag16_id = nil
                     elsif(arttagFound.tag17_id == tag)
                        arttagFound.tag17_id = nil
                     elsif(arttagFound.tag18_id == tag)
                        arttagFound.tag18_id = nil
                     elsif(arttagFound.tag19_id == tag)
                        arttagFound.tag19_id = nil
                     elsif(arttagFound.tag20_id == tag)
                        arttagFound.tag20_id = nil
                     else
                        #This case should never happen!
                        errorFlag = true
                     end
                     if(!errorFlag)
                        if(arttagFound.tag1_id.nil? && arttagFound.tag2_id.nil? && arttagFound.tag3_id.nil? && arttagFound.tag4_id.nil? && arttagFound.tag5_id.nil? && arttagFound.tag6_id.nil? && arttagFound.tag7_id.nil? && arttagFound.tag8_id.nil? && arttagFound.tag9_id.nil? && arttagFound.tag10_id.nil? && arttagFound.tag11_id.nil? && arttagFound.tag12_id.nil? && arttagFound.tag13_id.nil? && arttagFound.tag14_id.nil? && arttagFound.tag15_id.nil? && arttagFound.tag16_id.nil? && arttagFound.tag17_id.nil? && arttagFound.tag18_id.nil? && arttagFound.tag19_id.nil? && arttagFound.tag20_id.nil?)
                           arttagFound.tag1_id = 1
                        end
                        @arttag = arttagFound
                        @arttag.save
                        flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to arttags_path
                        else
                           redirect_to subfolder_art_path(@arttag.art.subfolder, @arttag.art)
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
                  allArttags = Arttag.all
                  @arttags = Kaminari.paginate_array(allArttags).page(getArttagParams("Page")).per(10)
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
