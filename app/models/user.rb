class User < ApplicationRecord
  validates :account, presence: true
  validates :password, presence: true
  has_many :missions
end
