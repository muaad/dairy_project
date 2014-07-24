# == Schema Information
#
# Table name: prices
#
#  id           :integer          not null, primary key
#  commodity_id :integer
#  price        :float
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  account_id   :integer
#

require 'test_helper'

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
