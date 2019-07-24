class Mission < ApplicationRecord

  validates :title, presence: true
  validate :end_time_better_start_time
  enum priority: { I18n.t("enum.low").to_s => 0, I18n.t("enum.medium").to_s => 1, I18n.t("enum.hight").to_s => 2 }
  enum status: { I18n.t("enum.waiting").to_s => 0, I18n.t("enum.conduct").to_s => 1, I18n.t("enum.finished").to_s => 2 }
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

  def self.search(value: )
    title = '%' + value + '%'
    status = statuses.values_at(*Array(value))
    where("status = ? OR title LIKE ?", status, title)
  end
end
