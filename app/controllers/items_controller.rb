class ItemsController < ApplicationController
	def index
		@item = Item.find_by_id(params[:id])
		
		#@items = [{:name => "French Table", :id => "item01", :description => "what a wonderfully UGLY table", :imageURL => "/images/item01.jpg"}, {:name => "Bed", :id => "item02", :description => "nothin' like a classic", :imageURL => "/images/item02.jpg"}, {:name => "New Crib", :id => "item03", :description => "new crib for my new crib", :imageURL => "/images/item03.jpg"}]
	end

	def create
		@item = Item.new
		if !params[:item][:imageURL]
			flash[:item_error] = "No file chosen"
			redirect_to :controller => "spaces", :action => "add"
		elsif params[:item][:name] == ""
			flash[:item_error] = "You must enter a name"
			redirect_to :controller => "spaces", :action => "add"
		else
			uploaded_io = params[:item][:imageURL]
			File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	    			file.write(uploaded_io.read)
	  		end

	  		@item.name = params[:item][:name]
	  		@item.description = params[:item][:description]
	  		@item.imageURL = uploaded_io.original_filename
	  		@item.borrowedTimes = 0
	  		@item.save
	  		redirect_to :action => "index", :id => @item.id
  		end
	end

end
