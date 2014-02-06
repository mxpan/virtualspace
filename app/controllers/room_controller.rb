class RoomController < ApplicationController
	def index
		@roomID = params[:id]
		@items = [{:name => "French Table", :id => "item01", :description => "what a wonderfully UGLY table", :imageURL => "/images/item01.jpg"}, {:name => "Bed", :id => "item02", :description => "nothin' like a classic", :imageURL => "/images/item02.jpg"}, {:name => "New Crib", :id => "item03", :description => "new crib for my new crib", :imageURL => "/images/item03.jpg"}]
	end

end
