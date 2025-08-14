class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy, :process_payment]

  def index
    if current_user.admin?
      render json: Subscription.all
    elsif current_user.owner?
      render json: current_user.subscriptions_as_owner
    elsif current_user.tenant?
      render json: current_user.subscriptions_as_tenant
    else
      render json: [], status: :forbidden
    end
  end

  def show
    authorize_subscription!(@subscription)
    render json: @subscription
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def authorize_subscription!(subscription)
    return if current_user.admin?
    return if subscription.owner_id == current_user.id
    return if subscription.tenant_id == current_user.id

    render json: { error: "Not authorized" }, status: :forbidden
  end
end
