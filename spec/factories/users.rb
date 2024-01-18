FactoryBot.define do
  factory :user do
    name { "kumiko" }
    email { "kumiko@gmail.com" }
    password { "5678910" }
    gender { 0 }
    age { 3 }
    nickname { "kumi" }
    self_introduction { "皆で情報共有して子供達を守りましょう！" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "satomi" }
    email { "satomi@gmail.com" }
    password { "123456" }
    gender { 0 }
    age { 4 }
    nickname { "sato" }
    self_introduction { "大切な子供達を守るために、このアプリを開設しました！貴重な情報お待ちしています。" }
    admin { true }
  end
  factory :other_user, class: User do
    name { "noriko" }
    email { "noriko@gmail.com" }
    password { "3456789" }
    gender { 0 }
    age { 2 }
    nickname { "nori" }
    self_introduction { "二児のママです！よろしくお願いします" }
    admin { false }
  end
end