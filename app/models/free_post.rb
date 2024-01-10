class FreePost < ApplicationRecord
  belongs_to :user
  validates :title, :content, :kind, :target_child_age, presence: true
  validates :title, length: { maximum: 100 }
  validates :content, length: { maximum: 1500 }

  scope :search, -> (title, target_child_age){ where('title LIKE ?',  "%#{title}%").where(target_child_age: target_child_age)}
  scope :title_search,  -> (title) { where('title LIKE ?',  "%#{title}%") }
  scope :target_child_age_search,  -> (target_child_age) { where(target_child_age: target_child_age) }

  enum kind: { "自宅にて": 0, "外出時": 1, "保育園・学校など": 2, "その他": 3 }
  enum target_child_age: { "0歳": 0, "1~2歳": 1, "3~5歳": 2, "6歳・小学生以上": 3, "中学生以上": 4 }
end