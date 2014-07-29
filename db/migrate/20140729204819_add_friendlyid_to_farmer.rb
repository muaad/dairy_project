class AddFriendlyidToFarmer < ActiveRecord::Migration
  def change
  	add_column :farmers, :slug, :string
	add_index :farmers, :slug, unique: true
  end
end
