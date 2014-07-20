# == Schema Information
#
# Table name: deliveries
#
#  id           :integer          not null, primary key
#  commodity_id :integer
#  farmer_id    :integer
#  quantity     :integer
#  price        :float
#  total        :float
#  paid_for     :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#

require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
