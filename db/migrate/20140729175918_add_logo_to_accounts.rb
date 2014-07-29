class AddLogoToAccounts < ActiveRecord::Migration
  def self.up
    add_attachment :accounts, :logo
  end

  def self.down
    remove_attachment :accounts, :logo
  end
end
