class RoomsController < ApplicationController
	def index
		@room = Room.find_by_id(params[:id])
		@items = @room.items
	end

	def create
		@room = Room.new
		if !params[:room][:imageURL]
			flash[:room_error] = "No file chosen"
			redirect_to :controller => "spaces", :action => "add"
		elsif params[:room][:name] == ""
			flash[:room_error] = "You must enter a name"
			redirect_to :controller => "spaces", :action => "add"
		else
			uploaded_io = params[:room][:imageURL]
			File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	    			file.write(uploaded_io.read)
	  		end

	  		user = User.find_by_id(session[:user_id])
	  		@room.user = user
	  		@room.name = params[:room][:name]
	  		@room.description = params[:room][:description]
	  		@room.imageURL = uploaded_io.original_filename
	  		@room.borrowedTimes = 0
	  		@room.save
	  		redirect_to :action => "index", :id => @room.id
  		end
	end
end
