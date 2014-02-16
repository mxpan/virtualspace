class ItemsController < ApplicationController
	def index
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
   		else
			@item = Item.find_by_id(params[:id])
			@tags = @item.tags
		end
	end

	def all
		if session[:user_id].nil?
       		flash[:error] = "Please log in or create an account"
      		redirect_to(:controller => :home, :action => :login)
    	else
			@user = User.find_by_id(session[:user_id])
			@items = Item.find_all_by_user_id(session[:user_id])
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
	  			redirect_to :action => "index", :controller => "spaces"
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
	  			redirect_to :action => "index", :controller => "spaces"
			else
		  		@item.name = params[:name]
		  		@item.description = params[:description]
		  		@item.room_id = params[:item][:room_id]
		  		if (params[:imageURL])
		  			uploaded_io = params[:imageURL]
					File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
			    			file.write(uploaded_io.read)
			    		end
		  			@item.imageURL = uploaded_io.original_filename
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
				redirect_to :controller => "spaces"
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
			  			@item.tags << tag
		  			end
		  		end

		  		@item.user_id = session[:user_id]
		  		@item.room_id = params[:item][:room_id]
		  		@item.name = params[:name]
		  		@item.description = params[:description]
		  		@item.imageURL = uploaded_io.original_filename
		  		@item.borrowedTimes = 0
		  		@item.save
		  		redirect_to :action => "index", :id => @item.id
	  		end
		end
	end
end
