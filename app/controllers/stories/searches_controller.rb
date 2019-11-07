# typed: strong
# frozen_string_literal: true

module Stories
  class SearchesController < ApplicationController
    # POST /stories/search
    sig { void }
    def create
      @query =
        T.let(
          params[:query],
          T.nilable(T.any(String, Numeric, ActionController::Parameters))
        )

      @stories =
        T.let(
          Story.search(@query).approved.feed_ordered,
          T.nilable(Story::ActiveRecord_Relation)
        )
    end
  end
end
