# typed: strict
# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  class SubscriptionParams < T::Struct
    class ObjectParams < T::Struct
      const :email, String
    end

    const :subscription, ObjectParams
  end

  # GET /subscriptions/new
  sig { void }
  def new
    @subscription = T.let(Subscription.new, T.nilable(Subscription))
  end

  # POST /subscriptions
  sig { void }
  def create
    @subscription =
      T.let(
        Subscription.new(subscription_params.serialize),
        T.nilable(Subscription)
      )

    render :new unless T.must(@subscription).save
  end

  private

  # strong params for subscriptions
  sig { returns(SubscriptionParams::ObjectParams) }
  def subscription_params
    TypedParams[SubscriptionParams].new.extract!(params).subscription
  end
end
