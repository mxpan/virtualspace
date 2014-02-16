class SettingsController < ApplicationController
	def index
		if session[:user_id].nil?
	       	flash[:error] = "Please log in or create an account"
	      	redirect_to(:controller => :home, :action => :login)
	    else
	    	@user = User.find_by_id(session[:user_id])
		end
	end

	def post_save
		username = params[:username]
		if username == ""
			flash[:error] = "Username cannot be blank"
			redirect_to(:action => :index)
		else
			user = User.find_by_id(session[:user_id])
			user.username = username

			if params[:password] != ""
				user.password = params[:password]
			end

			user.save
			flash[:notice] = "Saved changes"
			redirect_to(:action => :index)
		end
	end

	def post_delete
		user = User.find_by_id(session[:user_id])
		user.rooms.each do |room|
			room.destroy
		end

		user.items.each do |item|
			item.destroy
		end

		user.destroy

		reset_session
		flash[:message] = "Account deleted"
		redirect_to(:controller => :home, :action => :login)
	end
end
