class AddBankaccountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bank, :string
    add_column :users, :branch, :string
    add_column :users, :account_type, :string
    add_column :users, :account_number, :string
    add_column :users, :account_holder, :string
  end
end
