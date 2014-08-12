class AddFieldsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :trace, :string
    add_column :payments, :status, :string
  end
end
