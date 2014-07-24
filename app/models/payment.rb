# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  amount             :float
#  farmer_id          :integer
#  delivery_id        :integer
#  user_id            :integer
#  transaction_number :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Payment < ActiveRecord::Base
  belongs_to :farmer
  belongs_to :delivery
  belongs_to :user
  belongs_to :account
  acts_as_tenant(:account)
end
