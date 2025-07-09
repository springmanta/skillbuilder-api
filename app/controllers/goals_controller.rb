class GoalsController < ApplicationController
  before_action :authorize_request
  before_action :set_goal, only: [:show, :update]

  def index
    @goals = @current_user.goals.includes(:topic)
    render json: @goals, include: [:topic, :tags]
  end

  def show
    render json: @goal, include: [:topic, :tags]
  end

  def create
    @goal = @current_user.goals.build(goals_params)

    if @goal.save
      render json: @goal, status: :created
    else
      render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goals_params)
      render json: @goal, status: :ok
    else
      render json: { errors: @goal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def goals_params
    params.require(:goal).permit(:title, :description, :topic_id, tag_ids: [])
  end

  def set_goal
    @goal = @current_user.goals.find(params[:id])
  end
end
