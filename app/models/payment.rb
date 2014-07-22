class Payment < ActiveRecord::Base
  belongs_to :farmer
  belongs_to :delivery
  belongs_to :user
end
