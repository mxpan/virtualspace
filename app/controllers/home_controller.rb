class HomeController < ApplicationController
  def inspire
  	# search for latest items/rooms, return results
  	@new_items = Array.new();
  	@new_items.push("/images/room01.jpg");
  	@new_items.push("/images/room02.jpg");
  	@new_items.push("/images/room03.jpg");
  	@new_items.push("/images/room04.jpg");
  	@new_items.push("/images/room05.jpg");
  	@new_items.push("/images/room06.jpg");
  end
end
