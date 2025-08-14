class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :from_wallet, null: false, foreign_key: { to_table: :wallets }, type: :uuid
      t.references :to_wallet, null: false, foreign_key: { to_table: :wallets }, type: :uuid
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :currency, default: 'PKR'
      t.integer :payment_type, default: 0
      t.integer :status, default: 0
      t.text :failure_reason

      t.timestamps
    end
  end
end