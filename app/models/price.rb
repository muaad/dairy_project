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
#

class Price < ActiveRecord::Base
  belongs_to :commodity
  # belongs_to :account
  # acts_as_tenant(:account)
end
