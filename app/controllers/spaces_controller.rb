class SpacesController < ApplicationController
	def index
		if session[:user_id].nil?
	       	flash[:error] = "Please log in or create an account"
	      	redirect_to(:action => :login)
	    end
		user = User.find_by_id(session[:user_id])
		@username = user.username
		@itemsArr = user.items
		@roomsArr = user.rooms
	end

	def add
		@room = Room.new
		@item = Item.new
	end
end
