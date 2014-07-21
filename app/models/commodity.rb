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

class Commodity < ActiveRecord::Base
	has_many :deliveries
	has_many :prices
	# belongs_to :account
	# acts_as_tenant(:account)

	def latest_price
		prices.last.price
	end
end
