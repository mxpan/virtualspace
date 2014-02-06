class SpacesController < ApplicationController
	def index
		@username = "Jon";
  		@itemsArr = [{:name => "Living Room", :description => "a modern take on a classical design", :imageURL => "/images/room07.jpg"}, {:name => "Bedroom", :description => "who says the queen is the only one with gaudy taste", :imageURL => "/images/room08.jpg"}, {:name => "Future Kitchen", :description => "the future of the culinary arts is exciting and minimalistically designed", :imageURL => "/images/room09.jpg"}]
  		@itemsArr2 = [{:name => "apple", :description => "this is an apple", :imageURL => "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Culinary_fruits_front_view.jpg/1280px-Culinary_fruits_front_view.jpg"}, {:name => "banana", :description => "this is an banana", :imageURL => "http://thepaleodiet.com/wp-content/uploads/2013/05/fruit.jpg"}]
	end
end
