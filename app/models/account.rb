# == Schema Information
#
# Table name: accounts
#
#  id                :integer          not null, primary key
#  email             :string(255)
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  jp_user           :string(255)
#  jp_pass           :string(255)
#  jp_email          :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

class Account < ActiveRecord::Base
  has_many :user_accounts
  has_many :users, through: :user_accounts
  # validates_uniqueness_of :email, scope: :account_id
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "10X10>" }
end
