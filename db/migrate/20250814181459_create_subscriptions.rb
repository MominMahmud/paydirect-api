class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :tenant, null: false, foreign_key: { to_table: :users }, type: :uuid

      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :currency, default: 'PKR', null: false

      t.integer :frequency, default: 2, null: false # monthly
      t.date :next_due_date, null: false
      t.integer :retry_attempts, default: 0
      t.integer :status, default: 0 # active

      t.timestamps
    end
  end
end
