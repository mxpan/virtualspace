class SpacesController < ApplicationController
	def index
		@username = "Jon";
  		@itemsArr = [{:name => "Living Room", :id => "room07", :description => "a modern take on a classical design", :imageURL => "/images/room07.jpg"}, {:name => "Bedroom", :id => "room08", :description => "who says the queen is the only one with gaudy taste", :imageURL => "/images/room08.jpg"}, {:name => "Future Kitchen", :id => "room09", :description => "delicious yet stylish", :imageURL => "/images/room09.jpg"}, {:name => "Guest House", :id => "room10", :description => "people in glass houses should not throw stones unless your house is this well designed", :imageURL => "/images/room10.jpg"}]
  		@itemsArr2 = [{:name => "French Table", :id => "item01", :description => "what a wonderfully UGLY table", :imageURL => "/images/item01.jpg"}, {:name => "Bed", :id => "item02", :description => "nothin' like a classic", :imageURL => "/images/item02.jpg"}, {:name => "New Crib", :id => "item03", :description => "new crib for my new crib", :imageURL => "/images/item03.jpg"}]
	end

	def add
		
	end
end
