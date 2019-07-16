class User < ApplicationRecord
  validates_uniqueness_of :account, message: I18n.t("message.account") #確保唯一性
  validates_length_of :account, in: 4..10
  validates_length_of :password, :within => 6..15
  enum role: { user: 0, admin: 1 }
  has_many :missions
end
