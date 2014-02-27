class RoomsController < ApplicationController
	def index
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@room = Room.find_by_id(params[:id])
			@items = @room.items
			@tags = @room.tags
		end
	end

	def all
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
     		redirect_to(:controller => :home, :action => :login)
    	else
			@user = User.find_by_id(params[:id])
			@rooms = Room.find_all_by_user_id(params[:id])
		end
	end

	def edit
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@room = Room.find_by_id(params[:id])
			if @room.nil?
				flash[:error] = "Not a valid room"
	  			redirect_to :action => "index", :controller => "spaces"
			else
				@tags = @room.tags
				@tagString = ""
				@tags.each do |t|
					@tagString = @tagString + t.name + ", "
				end
			end
		end
	end

	def update
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@room = Room.find_by_id(params[:room_id])
			if @room.nil?
				flash[:error] = "Not a valid room"
	  			redirect_to :action => "index", :controller => "spaces"
			else
		  		@room.name = params[:name]
		  		@room.description = params[:description]
		  		if (params[:imageURL])
		  			@room.imageURL = params[:imageURL]
		  		end
		  		@room.tags.clear
		  		if params[:tags] != ""
		  			# split tag string using commas
		  			tagsArr = params[:tags].split(',').map(&:strip)
		  			tagsArr.each do |tagName|
			  			tag = Tag.find_by_name(params[:tagName])
			  			if tag.nil?
			  				tag = Tag.new
			  				tag.name = tagName
			  				tag.save
			  			end
			  			@room.tags << tag
		  			end
		  		end
		  		@room.save
		  		flash[:notice] = "Room updated!"
		  		redirect_to :action => "index", :id => @room.id
		  	end
		end
	end

	def delete
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@room = Room.find_by_id(params[:id])
			if !@room.nil?
				@room.destroy
				flash[:notice] = "Room deleted"
				redirect_to :controller => "spaces", :action => "index", :id => session[:user_id]
			end
		end
	end

	def create
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
	    else
			@room = Room.new
			if !params[:imageURL]
				flash[:room_error] = "No file chosen"
				redirect_to :controller => "spaces", :action => "add"
			elsif params[:name] == ""
				flash[:room_error] = "You must enter a name"
				redirect_to :controller => "spaces", :action => "add"
			else
		  		if params[:tags] != ""
		  			# split tag string using commas
		  			tagsArr = params[:tags].split(',').map(&:strip)
		  			tagsArr.each do |tagName|
			  			tag = Tag.find_by_name(params[:tagName])
			  			if tag.nil?
			  				tag = Tag.new
			  				tag.name = tagName
			  				tag.save
			  			end
			  			@room.tags << tag
		  			end
		  		end

		  		@room.user_id = session[:user_id]
		  		@room.name = params[:name]
		  		@room.description = params[:description]
		  		@room.imageURL = params[:imageURL]
		  		@room.borrowedTimes = 0
		  		@room.save
		  		redirect_to :action => "index", :id => @room.id
	  		end
		end
	end

	def post_borrow
		roomID = params[:room]
		desiredRoom = Room.find_by_id(roomID)
		borrowedRoom = Room.new
		borrowedRoom.name = desiredRoom.name
		borrowedRoom.description = desiredRoom.description
		borrowedRoom.imageURL = desiredRoom.imageURL
		borrowedRoom.borrowedTimes = 0
		borrowedRoom.user_id = session[:user_id]

		borrowedRoom.save

		desiredRoom.tags.each do |tag|
			newTag = Tag.new
			newTag.name = tag.name

			newTag.save

			borrowedRoom.tags << newTag
		end

		desiredRoom.items.each do |item|
			borrowedItem = Item.new
			borrowedItem.user_id = session[:user_id]
			borrowedItem.room_id = borrowedRoom.id
			borrowedItem.name = item.name
			borrowedItem.description = item.description
			borrowedItem.imageURL = item.imageURL
			borrowedItem.borrowedTimes = 0

			borrowedItem.save

			item.tags.each do |tag|
				newTag = Tag.new
				newTag.name = tag.name

				newTag.save

				borrowedItem.tags << newTag
			end
		end

		flash[:notice] = borrowedRoom.name+" was added to your spaces"
		redirect_to :controller=>:spaces, :action => :index, :id => session[:user_id]
	end
end
