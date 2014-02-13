class SearchController < ApplicationController
  	def index
  		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	end
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
end
