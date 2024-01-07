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
      

  


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

