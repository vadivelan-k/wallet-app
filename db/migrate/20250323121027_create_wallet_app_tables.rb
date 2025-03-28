class CreateWalletAppTables < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end

    create_table :wallets do |t|
      t.integer :user_id
      t.string  :wallet_type
      t.decimal :available_balance, default: 0.0
      t.decimal :actual_balance, default: 0.0

      t.timestamps
    end

    create_table :transactions do |t|
      t.integer :wallet_id
      t.string  :transaction_type
      t.integer :perform_by_id
      t.integer :receiver_id
      t.decimal :amount
      t.string  :status, default: 'pending'

      t.timestamps
    end
  end
end
