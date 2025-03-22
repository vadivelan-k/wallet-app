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
      t.decimal :available_balance
      t.decimal :actual_balance

      t.timestamps
    end

    create_table :transactions do |t|
      t.integer :wallet_id
      t.string  :transaction_type
      t.integer :sender_id
      t.decimal :amount
      t.string  :status, default: 'pending'

      t.timestamps
    end
  end
end
