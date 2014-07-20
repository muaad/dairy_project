class AddUserToCommodity < ActiveRecord::Migration
  def change
    add_reference :commodities, :user, index: true
  end
end
