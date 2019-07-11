class User < ApplicationRecord
  validates :account, presence: true, length: { minimum: 4 }
  validates_uniqueness_of :account
  validates :password, presence: true, length: { minimum: 6 }
  has_many :missions
end
