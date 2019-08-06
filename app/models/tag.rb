class Tag < ApplicationRecord
  validates_uniqueness_of :category
  has_many :tag_missions
  has_many :missions, through: :tag_missions, dependent: :destroy
end
