FactoryBot.define do
  factory :post do
    title { '小学生の女の子を狙った不審者発見' }
    content { '後ろから、スマホのカメラで、スカート付近を撮影していました！気をつけて下さい' }
    type { 0 }
    latitude { 35.77634497340798 }
    longitude { 139.66029484455572 }
  end
  factory :second_post, class: Post do
    title { 'へび発見' }
    content { '公衆トイレの後ろの林の下に黒い蛇がいました。毒性などはわかりませんが注意して下さい。' }
    type { 1 }
    latitude { 35.773736725820676 }
    longitude { 139.68195436801398 }
  end
end