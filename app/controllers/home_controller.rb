class HomeController < ApplicationController
  def index
  	# search for latest items/rooms, return results
    if session[:user_id].nil?
       flash[:error] = "Please log in or create an account"
      redirect_to(:action => :login)
    else
      @new_items = Room.find_by_sql("SELECT * from rooms ORDER BY \"borrowedTimes\" DESC LIMIT 6")
    end
  end

  def login
    if !session[:user_id].nil?
      redirect_to(:action => :index)
    end
  end

  def post_login
    email = params[:email]
    password = params[:password]

    user = User.find_by_email(email)
    if !user.nil?
      if user.password_valid?(password)
        session[:user_id] = user.id
        redirect_to(:action => :index)
      else
        flash[:error] = "Invalid Username or Password"
        redirect_to(:action => :login)
      end
    else
      flash[:error] = "Invalid Username or Password"
      redirect_to(:action => :login)
    end
  end

  def post_create_account
    @user = User.new
    @user.email = params[:email]
    @user.password = params[:password]
    @user.username = params[:username]

    if !@user.valid?
      render(:action => :login)
    else
      session[:user_id] = @user.id
      @user.save
      redirect_to(:action => :index)
   end
  end


  def logout
    reset_session
    redirect_to :action => :login
  end

end
