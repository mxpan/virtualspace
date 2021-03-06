class SpacesController < ApplicationController
	def index
		if session[:user_id].nil?
	       	flash[:error] = "Please log in or create an account"
	      	redirect_to(:controller => :home, :action => :login)
	    else
			@user = User.find_by_id(params[:id])
			@itemsArr = Item.where("user_id = ?", @user.id).order("updated_at DESC").limit(5)
			@roomsArr = Room.where("user_id = ?", @user.id).order("updated_at DESC").limit(5)
		end
	end

	def add
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@room = Room.new
			@item = Item.new
			@user = User.find_by_id(session[:user_id])
		end
	end
end
