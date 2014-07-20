class AddUserToPrice < ActiveRecord::Migration
  def change
    add_reference :prices, :user, index: true
  end
end
