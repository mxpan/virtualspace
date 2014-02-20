class HomeController < ApplicationController
  def index
  	# search for latest items/rooms, return results
    if session[:user_id].nil?
       flash[:error] = "Please log in or create an account"
      redirect_to(:action => :login)
    else
      @user = User.find_by_id(session[:user_id])
      @new_items = Room.find_by_sql("SELECT * from rooms ORDER BY updated_at DESC")
    end
  end

  def login
    if !session[:user_id].nil?
      redirect_to(:action => :index)
    end
  end

  def post_login
    email = params[:email]
    email = email.downcase
    password = params[:password]

    @user = User.find_by_email(email)
    if !@user.nil?
      if @user.password_valid?(password)
        session[:user_id] = @user.id
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
    @user.email = params[:email].downcase
    @user.password = params[:password]
    @user.username = params[:username]
    @user.first_login = 1

    if !@user.valid?
      render(:action => :login)
    else
      @user.save
      session[:user_id] = @user.id
      redirect_to(:action => :index)
   end
  end


  def logout
    reset_session
    redirect_to :action => :login
  end

end
