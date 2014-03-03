class ItemsController < ApplicationController
	def index
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
   		else
			@item = Item.find_by_id(params[:id])
			@tags = @item.tags
			@user = User.find_by_id(session[:user_id])
		end
	end

	def all
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@user = User.find_by_id(params[:id])
			@items = Item.find_all_by_user_id(params[:id])
		end
	end

	def edit 
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
	    else
			@item = Item.find_by_id(params[:id])
			if @item.nil?
				flash[:error] = "Not a valid item"
	  			redirect_to :action => "index", :controller => "spaces", :id => session[:user_id]
			else
				@user = User.find_by_id(session[:user_id])
				@tags = @item.tags
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
			@item = Item.find_by_id(params[:item_id])
			if @item.nil?
				flash[:error] = "Not a valid item"
	  			redirect_to :action => "index", :controller => "spaces", :id => session[:user_id]
			else
		  		@item.name = params[:name]
		  		@item.description = params[:description]
		  		@item.room_id = params[:item][:room_id]
		  		if (params[:imageURL])
		  			@item.imageURL = params[:imageURL]
		  		end
		  		@item.tags.clear
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
			  			@item.tags << tag
		  			end
		  		end
		  		@item.save
		  		flash[:notice] = "Item updated!"
		  		redirect_to :action => "index", :id => @item.id
		  	end
		end
	end

	def delete
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@item = Item.find_by_id(params[:id])
			if !@item.nil?
				@item.destroy
				flash[:notice] = "Item deleted"
				redirect_to :controller => "spaces", :action => "index", :id => session[:user_id]
			end
		end
	end

	def create
		if session[:user_id].nil?
      	 flash[:error] = "Please log in or create an account"
     	 redirect_to(:controller => :home, :action => :login)
   		else
			@item = Item.new
			if !params[:imageURL]
				flash[:item_error] = "No file chosen"
				redirect_to :controller => "spaces", :action => "add"
			elsif params[:name] == ""
				flash[:item_error] = "You must enter a name"
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
			  			@item.tags << tag
		  			end
		  		end

		  		@item.user_id = session[:user_id]
		  		@item.room_id = params[:item][:room_id]
		  		@item.name = params[:name]
		  		@item.description = params[:description]
		  		@item.imageURL = params[:imageURL]
		  		@item.borrowedTimes = 0
		  		@item.save
		  		redirect_to :action => "index", :id => @item.id
	  		end
		end
	end

	def post_borrow
		roomID = params[:room]
		item = Item.find_by_id(params[:item])
		item.borrowedTimes = item.borrowedTimes+1
		item.save

		borrowedItem = Item.new
		borrowedItem.user_id = session[:user_id]
		borrowedItem.name = item.name
		borrowedItem.description = item.description
		borrowedItem.imageURL = item.imageURL
		borrowedItem.borrowedTimes = 0

		if roomID != -1
			borrowedItem.room_id = roomID	
		end

		borrowedItem.save

		flash[:notice] = borrowedItem.name+" was added to your spaces"
		redirect_to :controller=>:spaces, :action => :index, :id => session[:user_id]
	end
end
