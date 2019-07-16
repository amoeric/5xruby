class Mission < ApplicationRecord
  validates :title, presence: true
  validate :end_time_better_start_time
  enum priority: { low: 0, medium: 1, hight: 2 }
  enum status: { waiting: 0, conduct: 1, finished: 2 }
  belongs_to :user

  has_many :tag_missions
  has_many :tags, through: :tag_missions
  private
  def end_time_better_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t("message.timerange"))
    end
 end
end
