# frozen_string_literal: true

module Admin
  class ApprovalsController < ApplicationController
    authenticate_admin

    # POST /admin/stories/:story_id/approval
    def create
      @story = Story.find(params[:story_id])
      @story.approve!
    end
  end
end
