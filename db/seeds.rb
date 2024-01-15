require 'faker'

16.times do |i|
  Area.create!(
    name: i
    )
end

9.times do |n|
  sample_name = Gimei.unique.female
  sample_email = Faker::Internet.email

  User.create!(
    name: sample_name, 
    email: sample_email, 
    password: "111111", 
    gender: 0,
    age: rand(1..5), 
    nickname: sample_name.last.romaji,
    admin: false
  )
end

sample_name = Gimei.unique.male
sample_email = Faker::Internet.email

User.create!(
    name: sample_name, 
    email: sample_email, 
    password: "111111", 
    gender: 1,
    age: rand(1..5), 
    nickname: sample_name.last.romaji,
    admin: true
  )

   user_ids = User.ids
  area_tokumaru = Area.find_by(name: 5)
  Post.create!(
    title: "不審者発生",
    content: "お菓子あげるから、こっちおいで〜と声をかけていた",
    type: 0,
    latitude: 35.77634497340798, 
    longitude: 139.66029484455572,
    area_id: area_tokumaru.id,
    user_id: user_ids.shuffle.first
  )
  area_nakadai = Area.find_by(name: 11)
  Post.create!(
    title: "へび発生",
    content: "体長約30センチの黒色のへびがいました",
    latitude: 35.773736725820676, 
    longitude: 139.68195436801398,
    type: 1,
    area_id: area_nakadai.id,
    user_id: user_ids.shuffle.first
    )
  area_shimura = Area.find_by(name: 12)
  Post.create!(
    title: "自転車の衝突事故発生",
    content: "曲がり角で自転車同士が衝突しました",
    latitude: 35.756055623466665,   
    longitude: 139.68684671714357,
    type: 2,
    area_id: area_shimura.id,
    user_id: user_ids.shuffle.first
    )
  area_minamitokiwadai = Area.find_by(name: 1)
  Post.create!(
    title: "女の子を狙った不審者発生",
    content: "小学生の女の子に後ろから抱きつき走って逃げて行きました",
    type: 0,
    latitude: 35.783807246771325, 
    longitude: 139.6724008233547, 
    type: 1,
    area_id: area_minamitokiwadai.id,
    user_id: user_ids.shuffle.first
    ) 
  area_wakagi = Area.find_by(name: 9)
  Post.create!(
    title: "道路が凍っていて危ないです",
    content: "昨晩の急激な寒さにより、坂道に氷が張ってて危ないです！",
    latitude: 35.77012855342803, 
    longitude: 139.67372108392922,
    type: 3,
    area_id: area_wakagi.id,
    user_id: user_ids.shuffle.first
    )

  20.times do |n|
    user_ids = User.ids
    area_ids = Area.ids
    Selecting.create!(
    area_id: area_ids.shuffle.first,
    user_id: user_ids.shuffle.first
    )
  end

  FreePost.create!(
    title: "夜遅くにちょっとした親の留守中に子どもが外出してしまいました",
    content: "夜11時頃、子どもを寝かしつけた後、明日の朝までに洗って乾かしてしまいたい洗濯物があったので、もう寝てるから30分ほどの外出であれば問題
    ないだろうと思い、近くのコインランドリーに出かけました。無事に乾燥まで終えて帰宅すると、なんと、6歳と3歳の姉弟の靴がなくなっていました。もう、体中に
    汗をかき愕然としました。すぐに警察に連絡をすると、「帰宅するかもしれないので、お母さんは自宅で待っててください」との指示。私はハラハラ
    しながら自宅で待ちました。今までの人生で最もハラハラした時間だったかもしれません。約30分後、警察から電話が入り、見つかったとの連絡が入りました。すぐに交番へ行き、なんとか子ども達と再会することができました。
    どうやら、二人を見かけたコンビニの店員さんが警察に通報してくれたようです。一夜明け、落ち着いた頃に6歳の姉に状況を確認すると、「目が覚めちゃって、
    そしたらパパもママもいないから、パパを迎えにパパが降りるバス停まで向かったんだ」とのことでした。子どもが寝たと思っても、夜の外出は本当に危険です！皆さんも
    気をつけてください。 ",
    kind: 0,
    target_child_age: 3,
    user_id: user_ids.shuffle.first
    )
  
  FreePost.create!(
    title: "そばアレルギーの子どもが、学校でアナフラキシーショックを起こしてしまいました",
    content: " 長男はそばアレルギーを持っていました。学校の先生に伝えていたのですが、先生達の連絡不足により、たまたま別の先生だった時に給食で蕎麦が出て、
    知らない先生は、残している長男に「残さず食べなさい」と叱ってしまい、長男は食べてしまいアナフラキシーショックを起こしてしまいました。先生達には面談の時などに
    よく話すようにしてください！",
    kind: 2,
    target_child_age: 3,
    user_id: user_ids.shuffle.first
    )

  FreePost.create!(
    title: "息子がスーパー内で迷子になり、そのまま行方不明になってしまいました",
    content: " パパと3歳の息子がスーパーで買い物を終えた後、先にパパがエスカレーターに乗り、息子が遅れて乗ったようなのですが、お互いに姿が見えなくなった状態
    になってしまいました。そんな中、パパは息子を探しましたが見つからず、試しに駐輪場に行くと、息子の自転車がなくなっていました。おそらくパパが先に帰ってしま
    ったと思い、息子も帰宅しようとしてしまったようです。パパは仕事中だったママに連絡し、ママは早退して、一緒に近所を探しました。幸い、スーパーと家の中間にあるパン屋の前
    で息子は見つかりました。そのスーパーと家の間の道は、道が細く歩道もなく、車が通る時はとても危険な道なので、怪我もなく無事でいてくれて本当に良かったです。しかし、
    、まさか自分で自転車に乗って行ってしまうとは思っても見ませんでした。子どもは大人が想像しないような行動をすることがあるので、本当に注意しましょう！",
    kind: 1,
    target_child_age: 2,
    user_id: user_ids.shuffle.first
    )

  FreePost.create!(
    title: "おにぎりを食べていた娘が喉に詰まらせて一時的に窒息状態になってしまいました",
    content: " 一般的に、窒息として注意されるのは、トマトやブドウなどの丸いもの、ナッツや豆など硬い豆型のもの、だと思いますので、おにぎりを食べている時は特に注意
    していませんでしたが、我が家の娘はおにぎりで窒息しました。急いで背中を叩き、なんとか詰まりを解消できましたが、本当びっくり冷や汗をかきました。小さな子どもの食事中
    は何が起こるかわかりませんね。注意しましょう。",
    kind: 0,
    target_child_age: 1,
    user_id: user_ids.shuffle.first
    )
  
  FreePost.create!(
    title: "息子が熱いコーヒーを浴びてしまい、大火傷を追ってしまいました",
    content: " テーブルの上に入れたての熱いコーヒーを置いていると、たまたまテーブル近くにいた息子がそのコーヒーに触ってこぼしてしまい、それが手にかかってしまい、
    手に大火傷を負ってしまいました。本当にかわいそうなことをしてしまいました。注意しましょう。",
    kind: 0,
    target_child_age: 0,
    user_id: user_ids.shuffle.first
    )
  
    post_ids = Post.ids
  Comment.create!(
    content: "情報ありがとうございます！",
    post_id: post_ids.shuffle.first
    )
  
  Comment.create!(
    content: "助かりました！",
    post_id: post_ids.shuffle.first
    )

  Comment.create!(
    content: "友人へも共有しました",
    post_id: post_ids.shuffle.first
    )

  Comment.create!(
    content: "気を付けます！ありがとうございます",
    post_id: post_ids.shuffle.first
    )

  Comment.create!(
    content: "学校へも連絡しました！ありがとうございました！",
    post_id: post_ids.shuffle.first
    )
      

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

