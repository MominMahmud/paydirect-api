class ProcessDueSubscriptionsJob < ApplicationJob
  queue_as :default

  def perform
    Subscription.active.where(next_due_date: Date.today).find_each do |subscription|
      subscription.process_payment
    end
  end
end