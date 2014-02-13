class HelpController < ApplicationController
  def index
  	if session[:user_id].nil?
       flash[:error] = "Please log in or create an account"
      redirect_to(:controller => :home, :action => :login)
    end
  end
end
