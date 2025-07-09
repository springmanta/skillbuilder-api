class TagsController < ApplicationController
  before_action :authorize_request, only: [:create]
  before_action :set_topic

  def index
    render json: @topic.tags
  end

  def create
    tag = Tag.find_or_create_by(name: tag_params[:name])

    unless @topic.tags.include?(tag)
      @topic.tags << tag
    end

    render json: tag, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
