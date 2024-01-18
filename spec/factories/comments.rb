FactoryBot.define do
  factory :comment do
    content { '貴重な情報ありがとうございます！' }
  end
  factory :second_comment, class: Comment do
    content { '助かります！' }
  end
end