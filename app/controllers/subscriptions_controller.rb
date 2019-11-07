# typed: strict
# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  # GET /subscriptions/new
  sig { void }
  def new
    @subscription = T.let(Subscription.new, T.nilable(Subscription))
  end

  # POST /subscriptions
  sig { void }
  def create
    @subscription = T.let(Subscription.new(subscription_params), T.nilable(Subscription))
    render :new unless T.must(@subscription).save
  end

  # GET /subscriptions/:id/verify
  sig { void }
  def verify
    @subscription = T.let(Subscription.find(params[:id]), T.nilable(Subscription))
    T.must(@subscription).verify!
  end

  private

  # strong params for subscriptions
  sig { returns(ActionController::Parameters) }
  def subscription_params
    subscription =
      params.require_typed(:subscription, TA[ActionController::Parameters].new)

    subscription.permit(:email)
  end
end
