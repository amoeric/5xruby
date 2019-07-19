class Tag < ApplicationRecord
  has_many :tag_missions
  has_many :missions, through: :tag_missions
end
