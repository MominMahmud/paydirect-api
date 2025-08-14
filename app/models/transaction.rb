class Transaction < ApplicationRecord
  belongs_to :from_wallet, class_name: 'Wallet'
  belongs_to :to_wallet, class_name: 'Wallet'
  enum :payment_type, { internal_wallet: 0 }
  enum :status, { pending: 0, success: 1, failed: 2 }

  validates :amount, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validate :different_wallets

  private

  def different_wallets
    errors.add(:base, "Sender and receiver cannot be the same wallet") if from_wallet_id == to_wallet_id
  end
end
