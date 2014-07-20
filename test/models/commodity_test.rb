# == Schema Information
#
# Table name: commodities
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  commodity_type :string(255)
#  units          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#

require 'test_helper'

class CommodityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
