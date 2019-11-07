# typed: true
# frozen_string_literal: true

module Admin
  class SubscriptionsController < ApplicationController
    authenticate_admin

    # GET /admin/subscriptions
    def index
      @subscriptions = Subscription.email_ordered
    end
  end
end
