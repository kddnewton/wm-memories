# typed: strict
# frozen_string_literal: true

class VerificationsController < ApplicationController
  # GET /subscriptions/:subscription_id/verification
  # This needs to be a GET action as it's being linked from emails.
  sig { void }
  def show
    @subscription =
      T.let(
        Subscription.find(params[:subscription_id]),
        T.nilable(Subscription)
      )

    T.must(@subscription).verify!
  end
end
