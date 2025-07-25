class TopicsController < ApplicationController
  before_action :authorize_request
  before_action :set_topic, only: [:show, :update, :destroy]

  def index
    @topics = Topic.includes(:tags).all
    render json: @topics.as_json(include: :tags), status: :ok
  end

  def show
    render json: @topic.as_json(include: :tags), status: :ok
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      assign_tags(@topic)
      render json: @topic, status: :created
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      render json: @topic, status: :ok
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def tag_names
    params.require(:topic).permit(tags: [])[:tags] || []
  end

def assign_tags(topic)
  tag_names = params.dig(:topic, :tags) || []

  tag_names.each do |tag_name|
    tag = Tag.find_or_create_by(name: tag_name.downcase)
    topic.tags << tag unless topic.tags.include?(tag)
  end
end
end
