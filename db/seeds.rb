puts "Clearing existing data..."
Transaction.destroy_all
Subscription.destroy_all
Wallet.destroy_all
User.destroy_all

puts "Creating Users with Devise + Roles..."

admin = User.create!(
  name: "System Admin",
  email: "admin@example.com",
  password: "123123",
  role: :admin
)

owner1 = User.create!(
  name: "Ali Khan",
  email: "ali@example.com",
  password: "123123",
  role: :owner
)

owner2 = User.create!(
  name: "Sara Malik",
  email: "sara@example.com",
  password: "123123",
  role: :owner
)

tenant1 = User.create!(
  name: "Ahmed Raza",
  email: "ahmed@example.com",
  password: "123123",
  role: :tenant
)

tenant2 = User.create!(
  name: "Fatima Noor",
  email: "fatima@example.com",
  password: "123123",
  role: :tenant
)

tenant3 = User.create!(
  name: "Bilal Iqbal",
  email: "bilal@example.com",
  password: "123123",
  role: :tenant
)

puts "Creating Wallets..."
[admin, owner1, owner2, tenant1, tenant2, tenant3].each do |user|
  Wallet.create!(user: user, balance: rand(5_000..20_000), currency: 'PKR')
end

puts "Creating Transactions..."
Transaction.create!(
  from_wallet: tenant1.wallet,
  to_wallet: owner1.wallet,
  amount: 15_000,
  currency: 'PKR',
  payment_type: :internal_wallet,
  status: :success
)

Transaction.create!(
  from_wallet: tenant2.wallet,
  to_wallet: owner1.wallet,
  amount: 12_000,
  currency: 'PKR',
  payment_type: :internal_wallet,
  status: :success
)

puts "Creating Subscriptions..."
Subscription.create!(
  owner: owner1,
  tenant: tenant1,
  amount: 15_000,
  currency: 'PKR',
  frequency: :monthly,
  next_due_date: Date.today + 5.days,
  status: :active
)

Subscription.create!(
  owner: owner1,
  tenant: tenant2,
  amount: 12_000,
  currency: 'PKR',
  frequency: :monthly,
  next_due_date: Date.today + 3.days,
  status: :active
)

Subscription.create!(
  owner: owner2,
  tenant: tenant3,
  amount: 10_000,
  currency: 'PKR',
  frequency: :monthly,
  next_due_date: Date.today + 7.days,
  status: :active
)

puts "Seeding complete!"
puts "Admin login:    admin@example.com / 123123"
puts "Owner1 login:   ali@example.com / 123123"
puts "Owner2 login:   sara@example.com / 123123"
puts "Tenant1 login:  ahmed@example.com / 123123"
puts "Tenant2 login:  fatima@example.com / 123123"
puts "Tenant3 login:  bilal@example.com / 123123"
