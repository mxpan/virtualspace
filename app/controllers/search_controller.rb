class SearchController < ApplicationController
  	def index
  	end


  	def find_objects
  		searchString = params[:search]
	  	@foundRooms = []
	  	@foundItems = []

		if searchString != ""
			#find rooms with tags containing substring
			tags = Tag.find(:all)
			tags.each do |tag|
				if tag.name.downcase.include?(searchString)
					rooms = tag.rooms
					rooms.each do |room|
						if (!@foundRooms.include?(room))
							@foundRooms << room
						end
					end

					items = tag.items
					items.each do |item|
						if (!@foundItems.include?(item))
							@foundItems << item
						end
					end
				end
			end
		end

		render :partial => "find_objects"


  	end

  	def find_rooms
	  	searchString = params[:search]
	  	@foundObjects = []

		if searchString != ""
			#find photos with tags containing substring
			tags = Tag.find(:all)
			tags.each do |tag|
				if tag.name.downcase.include?(searchString)
					rooms = tag.rooms
					rooms.each do |room|
						if (!@foundObjects.include?(room))
							@foundObjects << room
						end
					end
				end
			end
		end

		render :partial => "find_objects", :locals => {:nextPage => "/rooms/index", :objectType => "Rooms"}
  	end

  	def find_items
	  	searchString = params[:search]
	  	@foundObjects = []

		if searchString != ""
			#find photos with tags containing substring
			tags = Tag.find(:all)
			tags.each do |tag|
				if tag.name.downcase.include?(searchString)
					items = tag.items
					items.each do |items|
						if (!@foundObjects.include?(items))
							@foundObjects << items
						end
					end
				end
			end
		end

		render :partial => "find_objects", :locals => {:nextPage => "/items/index", :objectType => "Items"}
  	end
end
