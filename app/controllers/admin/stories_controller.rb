class Admin::StoriesController < ApplicationController

  authenticate_admin

  # GET /admin/stories
  def index
    @stories = Story.all
  end

end
