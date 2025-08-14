class TransactionsController < ApplicationController
  def index
    if current_user.admin?
      render json: Transaction.all
    elsif current_user.owner?
      tenant_ids = current_user.subscriptions_as_owner.pluck(:tenant_id)
      wallet_ids = Wallet.where(user_id: [tenant_ids, current_user.id]).pluck(:id)
      render json: Transaction.where(from_wallet_id: wallet_ids).or(Transaction.where(to_wallet_id: wallet_ids))
    elsif current_user.tenant?
      wallet_id = current_user.wallet.id
      render json: Transaction.where("from_wallet_id = ? OR to_wallet_id = ?", wallet_id, wallet_id)
    else
      render json: [], status: :forbidden
    end
  end
end
