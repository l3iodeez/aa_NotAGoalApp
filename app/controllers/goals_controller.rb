class GoalsController < ApplicationController
  before_action :set_goal, except: [:new, :create]
  before_action :verify_signed_in, except: :show
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  def complete
    unless @goal.completed
      @goal.completed = true
      @goal.save!
      redirect_to user_url(current_user)
    else
      redirect_to user_url(current_user)
    end
  end

  def edit
    render :edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal.delete
    redirect_to user_url(current_user)
  end

  private

    def goal_params
      params.require(:goal).permit(:title,:body,:private,:completed)
    end

    def set_goal
      @goal = Goal.find(params[:id])
    end

end
