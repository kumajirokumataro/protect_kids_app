class Post < ApplicationRecord
  belongs_to :area
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :type, :latitude, :longitude, presence: true
  validates :title, length: { maximum: 100 }
  validates :content, length: { maximum: 200 }
  enum type: { "不審者系": 0, "動物・虫系": 1, "交通事故系": 2, "その他": 3 }
  self.inheritance_column = :_type_disabled

  #geocoded_by :address
  #after_validation :geocode #if: :address_changed?

  #def address
    #name
  #end

end
