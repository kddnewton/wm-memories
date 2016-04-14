class StoriesController < ApplicationController

  layout 'file_upload', only: :create

  # GET /
  # GET /stories
  def index
    @stories = Story.approved
    @story = Story.new
  end

  # GET /stories/:id
  def show
    @story = Story.approved.find(params[:id])
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    render :create_error unless @story.save
  end

  # GET /stories/feed
  def feed
    @stories = Story.approved.feed_ordered
  end

  # GET /stories/search
  def search
    @query = params[:query]
    @stories = Story.search(@query).approved.feed_ordered
  end

  private

  # strong params for stories
  def story_params
    params.require(:story).permit(:year, :body, :lat, :lng, photo_proxies: [])
  end
end
