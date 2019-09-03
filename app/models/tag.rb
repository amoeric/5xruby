class Tag < ApplicationRecord
  validates :category, uniqueness: true
  has_many :tag_missions
  has_many :missions, through: :tag_missions, dependent: :destroy
end
