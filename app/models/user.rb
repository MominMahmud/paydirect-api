class User < ApplicationRecord
  extend Devise::Models
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, owner: 1, tenant: 2, both: 3 }

  has_one :wallet, dependent: :destroy
  has_many :subscriptions_as_owner, class_name: 'Subscription', foreign_key: 'owner_id'
  has_many :subscriptions_as_tenant, class_name: 'Subscription', foreign_key: 'tenant_id'
end
