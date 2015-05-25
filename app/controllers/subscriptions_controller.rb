class SubscriptionsController < ApplicationController

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    unless @subscription.save
      render :new
    end
  end

  # GET /subscriptions/:id/verify
  def verify
    @subscription = Subscription.find(params[:id])
    @subscription.verify!
  end

  private

    # strong params for subscriptions
    def subscription_params
      params.require(:subscription).permit(:email)
    end

end
