class TopicsController < ApplicationController
  before_action :authorize_request

  def index
    @topics = Topic.all
    render json: @topics, status: 200
  end

  def show
    @topic = Topic.find(params[:id])
    render json: @topic, status: 200
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: :created
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.save
      render json: @topic, status: 200
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end
