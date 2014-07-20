# == Schema Information
#
# Table name: farmers
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  phone_number        :string(255)
#  location            :string(255)
#  registration_number :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#

require 'test_helper'

class FarmerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
