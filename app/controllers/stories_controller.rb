# typed: strict
# frozen_string_literal: true

class StoriesController < ApplicationController
  layout 'file_upload', only: :create

  # This method here to enforce the types given by the instance variables
  sig { void }
  def initialize
    super

    @stories = T.let(nil, T.nilable(Story::ActiveRecord_Relation))
    @story = T.let(nil, T.nilable(Story))
  end

  # GET /
  # GET /stories
  sig { void }
  def index
    @stories = Story.approved
    @story = Story.new
  end

  # GET /stories/:id
  sig { void }
  def show
    @story = Story.approved.find(params[:id])
  end

  # POST /stories
  sig { void }
  def create
    @story = Story.new(story_params)
    render :create_error unless @story.save
  end

  # GET /stories/feed
  sig { void }
  def feed
    @stories = Story.approved.feed_ordered
  end

  # GET /stories/search
  sig { void }
  def search
    @query = T.let(params[:query], T.nilable(T.any(String, Numeric, ActionController::Parameters)))
    @stories = Story.search(@query).approved.feed_ordered
  end

  private

  # strong params for stories
  sig { returns(ActionController::Parameters) }
  def story_params
    story = params.require_typed(:story, TA[ActionController::Parameters].new)
    story.permit(:year, :body, :lat, :lng, photo_proxies: [])
  end
end
