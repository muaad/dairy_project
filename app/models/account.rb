# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
  has_many :users
  # validates_uniqueness_of :email, scope: :account_id
end
