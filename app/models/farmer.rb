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

class Farmer < ActiveRecord::Base
	has_many :deliveries
	belongs_to :user
	# belongs_to :account
 #  	acts_as_tenant(:account)

	def litres_delivered
		total = 0
		if !self.deliveries.nil?
			self.deliveries.each do |d|
				total = total + d.quantity
			end
		end
		total
	end

	def total_payout
		total = 0
		if !self.deliveries.nil?
			self.deliveries.each do |d|
				if d.paid_for
					total = total + d.total
				end
			end
		end
		total
	end

	def amount_owed
		total = 0
		if !self.deliveries.nil?
			self.deliveries.each do |d|
				if !d.paid_for
					total = total + d.total
				end
			end
		end
		total
	end
end
