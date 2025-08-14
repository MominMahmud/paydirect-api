class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets, id: :uuid  do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.decimal :balance
      t.string :currency

      t.timestamps
    end
  end
end
