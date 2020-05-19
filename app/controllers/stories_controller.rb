# typed: strict
# frozen_string_literal: true

class StoriesController < ApplicationController
  class StoryParams < T::Struct
    class ObjectParams < T::Struct
      const :year, T.nilable(Integer)
      const :body, String
      const :lat, T.nilable(Float)
      const :lng, T.nilable(Float)
      const :photo_proxies, T.nilable(
        T.any(
          T::Array[ActionDispatch::Http::UploadedFile],
          T::Array[Rack::Test::UploadedFile]
        )
      )
    end

    const :story, ObjectParams
  end

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
    @story = T.let(Story.new(story_params.serialize), T.nilable(Story))

    render :create_error unless T.must(@story).save
  end

  private

  # strong params for stories
  sig { returns(StoryParams::ObjectParams) }
  def story_params
    TypedParams[StoryParams].new.extract!(params).story
  end
end
