class UsersController < ApplicationController

  before_action :verify_signed_in, only: [:show]

  def show
    @user = User.includes(:goals).find(params[:id])
    @goals = @user.goals.order("created_at DESC")
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
