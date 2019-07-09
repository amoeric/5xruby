class User < ApplicationRecord
  validates :account, presence: true
  validates_uniqueness_of :account
  validates :password, presence: true
  has_many :missions
end
