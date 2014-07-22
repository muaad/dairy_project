class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount
      t.references :farmer, index: true
      t.references :delivery, index: true
      t.references :user, index: true
      t.string :transaction_number

      t.timestamps
    end
  end
end
