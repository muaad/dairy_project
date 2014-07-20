class AddAccountToDelivery < ActiveRecord::Migration
  def change
    add_reference :deliveries, :account, index: true
  end
end
