class User < ApplicationRecord
  has_secure_password
  validates :password, length: { in: 6..15 }
  validates :email, uniqueness: true, format: { with: /\w+@((\w+\w{2,}\.)\w{2,3})/,
                              message: I18n.t("message.email_invalid") }

  has_many :missions, dependent: :destroy
  enum role: { user: 0, admin: 1 }
  before_destroy :admin_must_has_one

  private
  def admin_must_has_one
    # if "比對刪除的是否是管理員，再去判斷是否勝一個"
    if self.admin? && User.where(role: 1).count == 1
      errors[:role] << "管理員至少要存在一個"
      throw :abort 
    end
  end
end