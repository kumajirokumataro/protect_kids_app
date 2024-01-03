class Area < ApplicationRecord
  has_many :selectings, dependent: :destroy
  has_many :users, through: :selectings
  has_many :selecting_users, through: :selectings, source: :user
  has_many :posts
  validates :name, uniqueness: true
  enum name: { "常盤台": 0, "南常盤台": 1, "高島平": 2, "大門": 3, "四葉": 4, "徳丸": 5, "西台": 6, "蓮根": 7,
               "坂下": 8, "若木": 9, "相生町": 10, "中台": 11, "志村": 12, "上板橋": 13, "小豆沢": 14, "東坂下": 15 }
end
