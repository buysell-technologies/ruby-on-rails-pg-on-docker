class SessionsController < ApplicationController
  def create
    email = params[:email]
    password = params[:password]
    if login(email, password)
      render json: {status: 'SUCCESS', data: @user.token}
    else
      render json: {status: 'User is not exist'}, status: 400
    end
  end

  def destroy
  end

  private
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      return true
    else
      return false
    end
  end
end
