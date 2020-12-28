# frozen_string_literal: true

class VerificationsController < ApplicationController
  # GET /subscriptions/:subscription_id/verification
  # This needs to be a GET action as it's being linked from emails.
  def show
    @subscription = Subscription.find(params[:subscription_id])
    @subscription.verify!
  end
end
