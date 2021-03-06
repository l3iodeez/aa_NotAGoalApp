class SessionsController < ApplicationController

  before_action :verify_signed_out, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end

  private

    def verify_signed_out
      redirect_to user_url(current_user) if signed_in?
    end

end
