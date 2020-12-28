# frozen_string_literal: true

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

  private

  # strong params for stories
  def story_params
    params.require(:story).permit(:year, :body, :lat, :lng, :photo_proxies)
  end
end
