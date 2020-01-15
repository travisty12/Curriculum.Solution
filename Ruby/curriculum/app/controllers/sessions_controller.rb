class SessionsController < ApplicationController
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "Login successful!"
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "There was an error logging you in. Please try again."
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Later, loser."
    redirect_to "/"
  end
end