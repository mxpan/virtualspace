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

		  		if params[:tag1] != ""
		  			tag1 = Tag.find_by_name(params[:tag1])
		  			if tag1.nil?
		  				tag1 = Tag.new
		  				tag1.name = params[:tag1]
		  				tag1.save
		  			end
		  			@room.tags << tag1
		  		end

		  		if params[:tag2] != ""
		  			tag2 = Tag.find_by_name(params[:tag2])
		  			if tag2.nil?
		  				tag2 = Tag.new
		  				tag2.name = params[:tag2]
		  				tag2.save
		  			end
		  			@room.tags << tag2
		  		end

		  		if params[:tag3] != ""
		  			tag3 = Tag.find_by_name(params[:tag3])
		  			if tag3.nil?
		  				tag3 = Tag.new
		  				tag3.name = params[:tag3]
		  				tag3.save
		  			end
		  			@room.tags << tag3
		  		end

		  		user = User.find_by_id(session[:user_id])
		  		@room.user = user
		  		@room.name = params[:name]
		  		@room.description = params[:description]
		  		@room.imageURL = uploaded_io.original_filename
		  		@room.borrowedTimes = 0
		  		@room.save
		  		redirect_to :action => "index", :id => @room.id
	  		end
		end
	end
end
