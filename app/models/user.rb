class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email, message: I18n.t("message.account") #確保唯一性
  validates_format_of :email, with: /\w+@((\w+\w{2,}\.)\w{2,3})/
  validates_length_of :password, :within => 6..15
  enum role: { user: 0, admin: 1 }
  has_many :missions
end
