class ItemsController < ApplicationController
	def index
		@item = Item.find_by_id(params[:id])
	end

	def create
		@item = Item.new
		if !params[:imageURL]
			flash[:item_error] = "No file chosen"
			redirect_to :controller => "spaces", :action => "add"
		elsif params[:name] == ""
			flash[:item_error] = "You must enter a name"
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
	  			@item.tags << tag1
	  		end

	  		if params[:tag2] != ""
	  			tag2 = Tag.find_by_name(params[:tag2])
	  			if tag2.nil?
	  				tag2 = Tag.new
	  				tag2.name = params[:tag2]
	  				tag2.save
	  			end
	  			@item.tags << tag2
	  		end

	  		if params[:tag3] != ""
	  			tag3 = Tag.find_by_name(params[:tag3])
	  			if tag3.nil?
	  				tag3 = Tag.new
	  				tag3.name = params[:tag3]
	  				tag3.save
	  			end
	  			@item.tags << tag3
	  		end

	  		user = User.find_by_id(session[:user_id])
	  		@item.user = user
	  		@item.name = params[:name]
	  		@item.description = params[:description]
	  		@item.imageURL = uploaded_io.original_filename
	  		@item.borrowedTimes = 0
	  		@item.save
	  		redirect_to :action => "index", :id => @item.id
  		end
	end
end
