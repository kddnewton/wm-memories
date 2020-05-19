# typed: strict
# frozen_string_literal: true

module Admin
  class SubscriptionsController < ApplicationController
    authenticate_admin

    # GET /admin/subscriptions
    sig { void }
    def index
      @subscriptions =
        T.let(
          Subscription.email_ordered,
          T.nilable(Subscription::ActiveRecord_Relation)
        )
    end
  end
end
