class AddUserToDelivery < ActiveRecord::Migration
  def change
    add_reference :deliveries, :user, index: true
  end
end
