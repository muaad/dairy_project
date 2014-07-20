class AddAccountToPrice < ActiveRecord::Migration
  def change
    add_reference :prices, :account, index: true
  end
end
