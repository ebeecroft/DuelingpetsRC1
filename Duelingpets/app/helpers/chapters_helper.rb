module ChaptersHelper

   private
      def getChapterParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "ChapterId")
            value = params[:chapter_id]
         elsif(type == "Book")
            value = params[:book_id]
         elsif(type == "Chapter")
            value = params.require(:chapter).permit(:title, :story, :voice1ogg, :remote_voice1ogg_url, :voice1ogg_cache,
            :voice1mp3, :remote_voice1mp3_url, :voice1mp3_cache, :voice2ogg, :remote_voice2ogg_url, :voice2ogg_cache,
            :voice2mp3, :remote_voice2mp3_url, :voice2mp3_cache, :voice3ogg, :remote_voice3ogg_url, :voice3ogg_cache,
            :voice3mp3, :remote_voice3mp3_url, :voice3mp3_cache, :bookcover, :remote_bookcover_url, :bookcover_cache,
            :storyscene1, :remote_storyscene1_url, :storyscene1_cache, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid)
         #Adds the chapter points to the economy
         newTransaction = Economy.new(params[:economy])
         newTransaction.econtype = "Content"
         newTransaction.content_type = "Chapter"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def updateBookworld(book)
         book.updated_on = currentTime
         @book = book
         @book.save
         bookworld = Bookworld.find_by_id(@book.bookworld_id)
         bookworld.updated_on = currentTime
         @bookworld = bookworld
         @bookworld.save
      end

      def editCommons(type)
         chapterFound = Chapter.find_by_id(getChapterParams("Id"))
         if(chapterFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == chapterFound.user_id) || logged_in.pouch.privilege == "Admin"))
               chapterFound.updated_on = currentTime
               chapterFound.reviewed = false

               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @chapter = chapterFound
               @book = Book.find_by_id(chapterFound.book.id)
               if(type == "update")
                  if((@chapter.bookcover.to_s != "" && @chapter.story.to_s == "") || (@chapter.story.to_s != "" && @chapter.bookcover.to_s == ""))
                     if(@chapter.update_attributes(getChapterParams("Chapter")))
                        updateBookworld(@book)
                        flash[:success] = "Chapter #{@chapter.title} was successfully updated."
                        redirect_to book_chapter_path(@chapter.book, @chapter)
                     else
                        render "edit"
                     end
                  else
                     flash[:error] = "An invalid selection was made!"
                     render "edit"
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def showCommons(type)
         chapterFound = Chapter.find_by_id(getChapterParams("Id"))
         if(chapterFound)
            removeTransactions
            if((current_user && ((chapterFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (checkBookgroupStatus(chapterFound)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @chapter = chapterFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == chapterFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Rebuilds the current chapter format
                     chapterNumber = @chapter.gchapter_id
                     bookFound = Book.find_by_id(@chapter.book_id)
                     allChapters = bookFound.chapters.all
                     fixChapters = allChapters.select{|chapter| chapter.gchapter_id > chapterNumber}
                     if(fixChapters.count > 0)
                        fixChapters.each do |chapter|
                           chapter.gchapter_id -= 1
                           @temp = chapter
                           @temp.save
                        end
                     end

                     #Removes the content and decrements the owner's pouch
                     cleanup = Fieldcost.find_by_name("Chaptercleanup")
                     chapterFound.user.pouch.amount -= cleanup.amount
                     @pouch = artFound.user.pouch
                     @pouch.save
                     economyTransaction("Tax", cleanup.amount, chapterFound.user.id)
                     @chapter.destroy
                     flash[:success] = "Chapter #{chapterFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to chapters_path
                     else
                        redirect_to bookworld_book_path(chapterFound.book.bookworld, chapterFound.book)
                     end
                  else
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
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
                  allChapters = Chapter.order("updated_on desc, created_on desc")
                  @chapters = Kaminari.paginate_array(allChapters).page(getChapterParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/bookworlds/maintenance"
                  end
               else
                  logged_in = current_user
                  bookFound = Book.find_by_id(getChapterParams("Book"))
                  if(logged_in && bookFound)
                     if(logged_in.id == bookFound.user_id || (bookFound.collab_mode &&
                        checkBookgroupStatus(bookFound)))
                        newChapter = bookFound.chapters.new
                        if(type == "create")
                           newChapter = bookFound.chapters.new(getChapterParams("Chapter"))
                           newChapter.created_on = currentTime
                           newChapter.updated_on = currentTime
                           newChapter.user_id = logged_in.id
                           chapterNumber = bookFound.chapters.count + 1

                           #Determines if we should create a new generalchapter
                           chapterFound = Gchapter.find_by_id(chapterNumber)
                           if(!chapterFound)
                              newGeneralChapter = Gchapter.new(params[:gchapter])
                              newGeneralChapter.title = "Chapter-" + chapterNumber.to_s
                              newGeneralChapter.created_on = currentTime
                              newGeneralChapter.chapternum = chapterNumber
                              @generalchapter = newGeneralChapter
                              @generalchapter.save
                              chapterFound = newGeneralChapter
                           end
                           newChapter.gchapter_id = chapterFound.id
                        end

                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups
                        @chapter = newChapter
                        @book = bookFound

                        if(type == "create")
                           if(@chapter.save)
                              chaptertag = Chaptertag.new(params[:chaptertag])
                              chaptertag.chapter_id = @chapter.id
                              chaptertag.tag1_id = 1
                              @chaptertag = chaptertag
                              @chaptertag.save
                              updateBookworld(@chapter.book)
                              url = "http://www.duelingpets.net/chapters/review"
                              ContentMailer.content_review(@chapter, "Chapter", url).deliver_now
                              flash[:success] = "#{@chapter.title} was successfully created."
                              redirect_to book_chapter_path(@book, @chapter)
                           else
                              render "new"
                           end
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  bookworldMode = Maintenancemode.find_by_id(12)
                  if(allMode.maintenance_on || bookworldMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allChapters = Chapter.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     chaptersToReview = allChapters.select{|chapter| !chapter.reviewed}
                     @chapters = Kaminari.paginate_array(chaptersToReview).page(getChapterParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  chapterFound = Chapter.find_by_id(getChapterParams("ChapterId"))
                  if(chapterFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           chapterFound.reviewed = true
                           chapterFound.reviewed_on = currentTime
                           updateBookworld(chapterFound.book)

                           #Saves the chapter
                           chapterpoints = Fieldcost.find_by_name("Chapter")
                           pointsForChapter = chapterpoints.amount
                           @chapter = chapterFound
                           @chapter.save
                           pouch = Pouch.find_by_user_id(@chapter.user_id)
                           pouch.amount += pointsForChapter
                           @pouch = pouch
                           @pouch.save
                           economyTransaction("Source", pointsForChapter, @chapter.user.id)

                           ContentMailer.content_approved(@chapter, "Chapter", pointsForChapters).deliver_now
                           #allWatches = Watch.all
                           #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                           #if(watchers.count > 0)
                           #   watchers.each do |watch|
                           #      UserMailer.new_art(@art, watch).deliver
                           #   end
                           #end
                           value = "#{@chapter.user.vname}'s chapter #{@chapter.title} was approved."
                        else
                           @sound = soundFound
                           ContentMailer.content_denied(@chapter, "Chapter").deliver_now
                           value = "#{@chapter.user.vname}'s chapter #{@chapter.title} was denied."
                        end
                        flash[:success] = value
                        redirect_to chapters_review_path
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
