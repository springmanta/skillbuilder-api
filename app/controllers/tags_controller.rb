class TagsController < ApplicationController
  before_action :authorize_request, only: [:create, :update]
  before_action :set_topic
  before_action :set_tag, only: [:update]

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

  def update
    
    if @tag.update(tag_params)
      render json: @tag, status: :ok
    else
      render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
