# typed: strong
# frozen_string_literal: true

module Stories
  class FeedsController < ApplicationController
    # GET /stories/feed
    sig { void }
    def show
      @stories =
        T.let(
          Story.approved.feed_ordered,
          T.nilable(Story::ActiveRecord_Relation)
        )
    end
  end
end
