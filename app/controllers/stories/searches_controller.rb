# frozen_string_literal: true

module Stories
  class SearchesController < ApplicationController
    # POST /stories/search
    def create
      @query = params[:query]
      @stories = Story.search(@query).approved.feed_ordered
    end
  end
end
