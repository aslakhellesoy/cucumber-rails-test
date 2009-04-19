class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    redirect_to '/login'
  rescue 
    redirect_to '/login'
  end

end
