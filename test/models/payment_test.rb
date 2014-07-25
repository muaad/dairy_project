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
#  account_id         :integer
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
