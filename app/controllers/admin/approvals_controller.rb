# typed: strict
# frozen_string_literal: true

module Admin
  class ApprovalsController < ApplicationController
    authenticate_admin

    # POST /admin/stories/:story_id/approval
    sig { void }
    def create
      @story = T.let(Story.find(params[:story_id]), T.nilable(Story))
      T.must(@story).approve!
    end
  end
end
