class Mission < ApplicationRecord
  validate :end_time_better_start_time
  validates :title, presence: true
  enum status: { waiting: 0, conduct: 1, finished: 2 }
  enum priority: { low: 0, medium: 1, hight: 2 }

  belongs_to :user
  has_many :tag_missions
  has_many :tags, through: :tag_missions
  
  def self.mission_expired(time)
    if time == "over"
      where('end_time <= ?', DateTime.now)
    elsif time == "notyet"
      where('end_time >= ?', DateTime.now)
    end
  end

  def self.ransackable_scopes(auth_object = nil)
    %i(mission_expired)
  end

  private
  def end_time_better_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t("message.timerange"))
    end
  end
end
