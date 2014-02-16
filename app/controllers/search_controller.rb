class SearchController < ApplicationController
  	def index
  		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	end

    	@query = params[:search]
  	end


  	def find_objects
  		searchString = params[:search]
	  	@foundRooms = []
	  	@foundItems = []

		if searchString != ""
			# find rooms with tags containing substring

			rooms = Room.find_by_sql("SELECT * from Rooms where name like '%"+searchString+"%'")
			@foundRooms = @foundRooms + rooms

			items = Item.find_by_sql("SELECT * from Items where name like '%"+searchString+"%'")
			@foundItems = @foundItems + items

			roomTags = Room.find_by_sql("SELECT * from rooms r where r.id in (SELECT r.id from rooms r, rooms_tags, tags t where r.id = rooms_tags.room_id and t.id = rooms_tags.tag_id and t.name like '%"+searchString+"%')")
			roomTags.each do |rt|
				if !@foundRooms.include?(rt)
					@foundRooms << rt
				end
			end

			itemTags = Item.find_by_sql("SELECT * from items i where i.id in (SELECT i.id from items i, items_tags, tags t where i.id = items_tags.item_id and t.id = items_tags.tag_id and t.name like '%"+searchString+"%')")
			itemTags.each do |it|
				if !@foundItems.include?(it)
					@foundItems << it
				end
			end
		end

		render :partial => "find_objects"

  	end
end
