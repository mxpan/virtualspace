class ItemController < ApplicationController
  def index
  	@itemID = params[:id]
  end
end
