module BooksHelper

   private
      def getBookParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Bookworld")
            value = params[:bookworld_id]
         elsif(type == "Book")
            value = params.require(:book).permit(:title, :description, :bookgroup_id, :collab_mode, :gviewer_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def updateBookworld(bookworld)
         bookworld.updated_on = currentTime
         @bookworld = bookworld
         @bookworld.save
      end

      def editCommons(type)
         bookFound = Book.find_by_id(getBookParams("Id"))
         if(bookFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == bookFound.user_id) || logged_in.pouch.privilege == "Admin"))
               bookFound.updated_on = currentTime
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               #Allows us to select the user who can view the book
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers
               @book = bookFound
               @bookworld = Bookworld.find_by_name(bookFound.bookworld.name)
               if(type == "update")
                  if(@book.update_attributes(getBookParams("Book")))
                     updateBookworld(@bookworld)
                     flash[:success] = "Book #{@book.title} was successfully updated."
                     redirect_to bookworld_book_path(@book.bookworld, @book)
                  else
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
         bookFound = Book.find_by_id(getBookParams("Id"))
         if(bookFound)
            removeTransactions
            if((current_user && ((bookFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(bookFound))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @book = bookFound

               chapters = bookFound.chapters
               @chapters = Kaminari.paginate_array(chapters).page(getBookParams("Page")).per(1)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == bookFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @book.destroy
                     flash[:success] = "#{bookFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to books_path
                     else
                        redirect_to user_bookworld_path(bookFound.bookworld.user, book.bookworld)
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
                  allBooks = Book.order("updated_on desc, created_on desc")
                  @books = Kaminari.paginate_array(allBooks).page(getBookParams("Page")).per(10)
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
                  bookworldFound = Bookworld.find_by_name(getBookParams("Bookworld"))
                  if(logged_in && bookworldFound)
                     newBook = bookworldFound.books.new
                     if(type == "create")
                        newBook = bookworldFound.books.new(getBookParams("Book"))
                        newBook.created_on = currentTime
                        newBook.updated_on = currentTime
                        newBook.user_id = logged_in.id
                     end

                     allGroups = Bookgroup.order("created_on desc")
                     allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                     @group = allowedGroups

                     #Allows us to select the user who can view the book
                     gviewers = Gviewer.order("created_on desc")
                     @gviewers = gviewers

                     @book = newBook
                     @bookworld = bookworldFound

                     if(type == "create")
                        worldOwner = (logged_in.id == bookworldFound.user_id)
                        if(worldOwner || bookworld.open_world)
                           bookcost = (logged_in.pouch.amount - bookworldFound.price)
                           if(worldOwner || (!worldOwner && bookcost >= 0))
                              if(@book.save)
                                 if(!worldOwner)
                                    #Decrement the buyer's pouch
                                    logged_in.pouch.amount -= bookworldFound.price
                                    @pouch = logged_in.pouch
                                    @pouch.save

                                    #Might add a small tax of 10%
                                    #Increment the worldOwner's pouch
                                    bookworldFound.user.pouch.amount += bookworldFound.price
                                    @pouch2 = bookworldFound.user.pouch
                                    @pouch2.save
                                 end

                                 updateBookworld(@book.bookworld)
                                 flash[:success] = "#{@book.title} was successfully created."
                                 redirect_to bookworld_book_path(@bookworld, @book)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create a book!"
                              redirect_to root_path
                           end
                        else
                           flash[:error] = "Only the bookworld owner can create books for this series!"
                           redirect_to root_path
                        end
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
            end
         end
      end
end
