class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :selectings, dependent: :destroy
  has_many :areas, through: :selectings
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 80 }
  validates :nickname, length: { maximum: 40 }
  validates :self_introduction, length: { maximum: 200 }
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password_digest, length: { minimum: 6 }
  has_secure_password
  enum gender: { "女性": 0, "男性": 1 }
  enum age: { "10歳未満": 0, "10代": 1,"20代": 2, "30代": 3, "40代": 4,"50代": 5, "60代": 6,"70代": 7, "80歳以上": 8  }
  before_destroy :not_admin_destroy
  before_update :not_admin_update

  
  def not_admin_destroy
    throw (:abort) if self.admin == true && User.where(admin: true).count == 1
  end

  def not_admin_update
    if self.admin_change == [true, false] && User.where(admin: true).count == 1
      throw (:abort)
      flash[:notice]="管理者は一人以上必要です！"
    end 
  end
end
