class Wallet < ApplicationRecord
  belongs_to :user
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'from_wallet_id'
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'to_wallet_id'

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true

  def transfer_to(target_wallet, amount)
    raise ArgumentError, "Cannot transfer to same wallet" if id == target_wallet.id
    raise "Insufficient balance" if balance < amount

    ApplicationRecord.transaction do
      update!(balance: balance - amount)
      target_wallet.update!(balance: target_wallet.balance + amount)

      Transaction.create!(
        from_wallet: self,
        to_wallet: target_wallet,
        amount: amount,
        currency: currency,
        payment_type: :internal_wallet,
        status: :success
      )
    end
  end
end