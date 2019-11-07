# typed: strict
# frozen_string_literal: true

module Admin
  class StoriesController < ApplicationController
    authenticate_admin

    # GET /admin/stories
    sig { void }
    def index
      @stories =
        T.let(Story.feed_ordered, T.nilable(Story::ActiveRecord_Relation))
    end

    # PATCH /admin/stories/:id/approve
    sig { void }
    def approve
      @story = T.let(Story.find(params[:id]), T.nilable(Story))
      T.must(@story).approve!
    end

    # GET /admin/stories/:id
    sig { void }
    def show
      @story = T.let(Story.find(params[:id]), T.nilable(Story))
      render 'stories/show'
    end
  end
end
