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
			@user = User.find_by_id(session[:user_id])
			@rooms = Room.find_all_by_user_id(session[:user_id])
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
		  			uploaded_io = params[:imageURL]
					File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
			    			file.write(uploaded_io.read)
			    		end
		  			@room.imageURL = uploaded_io.original_filename
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
				redirect_to :controller => "spaces"
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
				uploaded_io = params[:imageURL]
				File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
		    			file.write(uploaded_io.read)
		  		end

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
		  		@room.imageURL = uploaded_io.original_filename
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

		desiredRoom.items.each do |item|
			borrowedItem = Item.new
			borrowedItem.user_id = session[:user_id]
			borrowedItem.room_id = roomID
			borrowedItem.name = item.name
			borrowedItem.description = item.description
			borrowedItem.imageURL = item.imageURL
			borrowedItem.borrowedTimes = 0

			borrowedItem.save
		end

		flash[:notice] = borrowedRoom.name+" was added to your spaces"
		redirect_to :controller=>:spaces, :action => :index
	end
end
