class GoalsController < ApplicationController
  before_action :authorize_request

  def index
    @goals = @current_user.goals.includes(:topic)
    render json: @goals, include: :topic
  end

  def create
    @goal = @current_user.goals.build(goals_params)

    if @goal.save
      render json: @goal, status: :created
    else
      render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def goals_params
    params.require(:goal).permit(:title, :description, :topic_id)
  end
end
