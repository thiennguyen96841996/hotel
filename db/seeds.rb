admin = User.create({name: 'admin', email: 'admin@gmail.com', password: 'asd123!',
  password_confirmation: "asd123!", })
admin.admin!
admin.skip_confirmation!
admin.save

equip1 = Equipment.create({name: "Wifi"})
equip2 = Equipment.create({name: "プール"})
equip3 = Equipment.create({name: "ジム"})
equip4 = Equipment.create({name: "温泉"})

room1 = Room.create({room_type: "シングル", bed_numbers: 1, guest_no: 1})
room2 = Room.create({room_type: "ダブル", bed_numbers: 1, guest_no: 2})
room3 = Room.create({room_type: "ツイン", bed_numbers: 2, guest_no: 2})
room4 = Room.create({room_type: "トリプル", bed_numbers: 2, guest_no: 3})
image_data = Rails.root.join("app/assets/images/hotel.jpg").open

30.times do |n|
    motel = Motel.create! name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph(50),
    phone: Faker::Number.number(11).to_i,
    level: Faker::Number.within(0..5),
    images: [image_data]
end

30.times do |n|
  user = User.create!({name: Faker::FunnyName.name, email: Faker::Internet.email , password: 'asd123!',
    password_confirmation: "asd123!", })
  user.skip_confirmation!
  user.save
end

10.times do |n|
  review = Review.create({title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph(50),
   user_id: Faker::Number.within(0..10), motel_id: Faker::Number.within(0..2), rate: Faker::Number.within(0..5)})
end

10.times do |n|
  like = Like.create({user_id: Faker::Number.unique.within(1..10), review_id: Faker::Number.within(1..10)})
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
