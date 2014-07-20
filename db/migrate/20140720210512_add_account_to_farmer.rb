class AddAccountToFarmer < ActiveRecord::Migration
  def change
    add_reference :farmers, :account, index: true
  end
end
