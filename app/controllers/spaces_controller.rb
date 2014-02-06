class SpacesController < ApplicationController
	def index
		@username = "Jon";
  		@itemsArr = [{:name => "apple", :description => "this is an apple", :imageURL => "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Culinary_fruits_front_view.jpg/1280px-Culinary_fruits_front_view.jpg"}]
  		@itemsArr2 = [{:name => "apple", :description => "this is an apple", :imageURL => "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Culinary_fruits_front_view.jpg/1280px-Culinary_fruits_front_view.jpg"}, {:name => "banana", :description => "this is an banana", :imageURL => "http://thepaleodiet.com/wp-content/uploads/2013/05/fruit.jpg"}]
	end
end
