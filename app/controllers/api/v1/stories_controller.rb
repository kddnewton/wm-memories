class Api::V1::StoriesController < ApplicationController

  # GET /api/v1/stories
  def index
    @stories = Story.approved.feed_ordered
  end

  # GET /api/v1/stories/:id
  def show
    @story = Story.approved.find_by_id(params[:id])
    if @story.nil?
      render json: { error: 'Record not found.' }, status: :not_found
    end
  end

  # POST /api/v1/stories
  def create
    @story = Story.new(story_params)
    if @story.save
      render status: :created
    else
      render json: { error: 'Invalid parameters.' }, status: :bad_request
    end
  end

  private

    # strong params for stories
    def story_params
      params.require(:story).permit(:year, :body, :lat, :lng)
    end
end
