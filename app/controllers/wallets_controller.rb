class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :update, :top_up]

  def show
    authorize_wallet!(@wallet)
    render json: @wallet
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  def authorize_wallet!(wallet)
    return if current_user.admin?
    return if wallet.user == current_user
    return if current_user.owner? && current_user.subscriptions_as_owner.exists?(tenant_id: wallet.user.id)

    render json: { error: "Not authorized" }, status: :forbidden
  end
end
