class HomeController < ApplicationController
  def index
  	# search for latest items/rooms, return results
    id = params[:id];

    # user is not logged in
    if id.nil?
      redirect_to(:action => :login)
    end

  	@new_items = Array.new();
  	@new_items.push("/images/room01.jpg")
  	@new_items.push("/images/room02.jpg")
  	@new_items.push("/images/room03.jpg")
  	@new_items.push("/images/room04.jpg")
  	@new_items.push("/images/room05.jpg")
  	@new_items.push("/images/room06.jpg")
  end

  def login
    
  end

  def post_login
    email = params[:email]
    password = params[:password]

    user = User.find_by_email(email)
    if !user.nil?
      if user.password_valid?(password)
        redirect_to(:action => :index, :id => user.id)
      else
        # display error
        # render(:action => :login, :id => user.id)
      end
    end
  end

  def post_create_account
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.username = params[:username]

    user.save
    redirect_to(:action => :index, :id => user.id)
  end

end
