# typed: false
# frozen_string_literal: true

class StoriesController < ApplicationController
  layout 'file_upload', only: :create

  # GET /
  # GET /stories
  sig { void }
  def index
    @stories = T.let(Story.approved, T.nilable(Story::ActiveRecord_Relation))
    @story = T.let(Story.new, T.nilable(Story))
  end

  # GET /stories/:id
  sig { void }
  def show
    @story = T.let(Story.approved.find(params[:id]), T.nilable(Story))
  end

  # POST /stories
  sig { void }
  def create
    @story = T.let(Story.new(story_params), T.nilable(Story))

    render :create_error unless T.must(@story).save
  end

  private

  # strong params for stories
  sig { returns(ActionController::Parameters) }
  def story_params
    story = params.require_typed(:story, TA[ActionController::Parameters].new)
    story.permit(:year, :body, :lat, :lng, photo_proxies: [])
  end
end
