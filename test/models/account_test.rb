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

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
