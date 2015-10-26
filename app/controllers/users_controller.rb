class UsersController < ApplicationController

  before_action :verify_signed_in, only: [:show]

  def show
    @user = User.includes(:goals).order("goals.created_at DESC").find(params[:id])
    @goals = @user.goals

      render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end


  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

end
