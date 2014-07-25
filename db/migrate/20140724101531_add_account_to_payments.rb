class AddAccountToPayments < ActiveRecord::Migration
  def change
    add_reference :payments, :account, index: true
  end
end
