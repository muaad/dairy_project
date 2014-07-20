class AddAccountToCommodity < ActiveRecord::Migration
  def change
    add_reference :commodities, :account, index: true
  end
end
