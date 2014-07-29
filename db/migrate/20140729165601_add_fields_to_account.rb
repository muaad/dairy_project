class AddFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :jp_user, :string
    add_column :accounts, :jp_pass, :string
    add_column :accounts, :jp_email, :string
  end
end
