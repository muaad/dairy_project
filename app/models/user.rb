# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(255)      default("")
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  name                     :string(255)
#  confirmation_token       :string(255)
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  unconfirmed_email        :string(255)
#  invitation_token         :string(255)
#  invitation_created_at    :datetime
#  invitation_sent_at       :datetime
#  invitation_accepted_at   :datetime
#  invitation_limit         :integer
#  invited_by_id            :integer
#  invited_by_type          :string(255)
#  invitations_count        :integer          default(0)
#  profile_pic_file_name    :string(255)
#  profile_pic_content_type :string(255)
#  profile_pic_file_size    :integer
#  profile_pic_updated_at   :datetime
#  is_admin                 :boolean
#  account_id               :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # after_create :make_admin
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_accounts
  has_many :accounts, through: :user_accounts
  belongs_to :account
  acts_as_tenant(:account)
  # if Rails.env.production?
  #   has_attached_file :profile_pic,
  #   :storage => :dropbox,
  #   :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  # else
    has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "10X10>" }, :default_url => "assets/avatar.png"
  # end
  has_many :farmers
  has_many :deliveries
  has_many :commodities
  has_many :prices
  has_many :payments

  def farmers_registered
    farmers.count
  end

  def deliveries_recorded
    deliveries.count
  end
  
  def payments_authorized
    payments.pluck("amount").inject(:+)
  end

  def activities
    # {
    #   "farmers" => farmers,
    #   "deliveries" => deliveries,
    # }
    activities = {}
    farmers.each do |farmer|
      activities["farmers"] = {farmer.name => farmer}
    end
    deliveries.each do |delivery|
      activities["deliveries"] = {delivery.id => delivery}
    end
    activities
  end

  # def make_admin
  #   account = Account.find_or_create_by! email: self.email
  #   self.is_admin = true
  #   # self.account_id = account.id
  #   self.save!
  #   UserAccount.create! user_id: self.id, account_id: account.id
  # end
end
