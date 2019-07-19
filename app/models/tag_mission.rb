class TagMission < ApplicationRecord
  belongs_to :tag
  belongs_to :mission
end
