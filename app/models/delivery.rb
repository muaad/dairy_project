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

class Delivery < ActiveRecord::Base
  belongs_to :commodity
  belongs_to :farmer
  # belongs_to :account
  # acts_as_tenant(:account)

  def delivered_by
  	self.farmer.name
  end

  def item_name
  	self.commodity.name
  end
end
