# frozen_string_literal: true

module Stories
  class FeedsController < ApplicationController
    # GET /stories/feed
    def show
      @stories = Story.approved.feed_ordered
    end
  end
end
