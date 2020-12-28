# frozen_string_literal: true

module Admin
  class StoriesController < ApplicationController
    authenticate_admin

    # GET /admin/stories
    def index
      @stories = Story.feed_ordered
    end

    # GET /admin/stories/:id
    def show
      @story = Story.find(params[:id])
      render 'stories/show'
    end
  end
end
