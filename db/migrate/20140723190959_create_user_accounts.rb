class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.references :user, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
