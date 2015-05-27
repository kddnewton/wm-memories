class StoriesController < ApplicationController

  # GET /
  # GET /stories
  def index
    @stories = Story.approved
    @story = Story.new
  end

  # GET /stories/:id
  def show
    @story = Story.find(params[:id])
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    unless @story.save
      render 'create_error'
    end
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
      params.require(:story).permit(:year, :body, :lat, :lng)
    end

end
