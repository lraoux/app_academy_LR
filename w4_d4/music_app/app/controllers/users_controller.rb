class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.reset_session_token!
    if @user.save!
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end



  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
