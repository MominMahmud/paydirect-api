class Subscription < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :tenant, class_name: 'User'

  enum :frequency, { daily: 0, weekly: 1, monthly: 2, yearly: 3 }
  enum :status, { active: 0, paused: 1, cancelled: 2 }

  validates :amount, numericality: { greater_than: 0 }
  validates :next_due_date, presence: true

  def process_payment
    tenant_wallet = tenant.wallet
    owner_wallet = owner.wallet

    if tenant_wallet.balance >= amount
      tenant_wallet.transfer_to(owner_wallet, amount)
      update!(
        next_due_date: calculate_next_due_date,
        retry_attempts: 0
      )
      return { success: true, message: "Payment successful" }
    else
      increment!(:retry_attempts)
      return { success: false, message: "Insufficient balance" }
    end
  end

  private

  def calculate_next_due_date
    case frequency
    when "daily"   then next_due_date + 1.day
    when "weekly"  then next_due_date + 1.week
    when "monthly" then next_due_date + 1.month
    when "yearly"  then next_due_date + 1.year
    end
  end
end
