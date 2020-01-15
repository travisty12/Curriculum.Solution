class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Signup successful!"
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = "There was an error signing up. Please try again."
      redirect_to '/signup' 
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end