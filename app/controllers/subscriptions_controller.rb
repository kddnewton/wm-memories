# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)

    render :new unless @subscription.save
  end

  private

  # strong params for subscriptions
  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
