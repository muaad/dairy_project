class AddUserToFarmer < ActiveRecord::Migration
  def change
    add_reference :farmers, :user, index: true
  end
end
