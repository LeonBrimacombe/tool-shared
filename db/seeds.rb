# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Overview: Setting up an API to import tool names from dictionary website.

# 1) Import required depend

require "faker"

# 2) Prepare tags and import, then parse file into results array.

puts "Cleaning user database"
User.destroy_all

puts "Seeding user DB"
test_user = User.new(
  email: "test@test.com",
  password: "123456",
  username: "magnus-jr"
)
test_user.save

3.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    username: Faker::Internet.user_name
  )
  user.save
end

profile_photos = [
  "https://avatars.githubusercontent.com/u/73750355?v=4",
  "https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBeXB2QXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--ec570f8e7ba217d7dd50b05f8c190fd677268763/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/IMG_9339.jpg",
  "https://avatars.githubusercontent.com/u/183761743?v=4",
]

User.all.each do |user|
  user.image.attach(
    io: URI.open(profile_photos.sample),
    filename: "profile.jpg",
    content_type: "image/jpeg"
  )
  user.save!
end

puts "Users seeded!"

Tool.destroy_all
puts "Cleaning tools DB"
puts "Seeding tools DB"

categories = [
  "Batteries, Chargers and Power Supplies",
  "Power Tools",
  "Outdoor Power Equipment",
  "Sewage and Drain Cleaning",
  "Lighting",
  "Instruments",
  "Storage",
  "Personal Protective Equipment",
  "Heated Work Wear and Clothing",
  "Hand Tools"
]

seed_tools = [
  {
  name: "Reciprocating saw",
  description: "MAKITA DJR186Z
    18v Reciprocating saw, with variable speed.
    Depth of cut: 255mm, can rent with cardboard box",
  price: 2000,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "24 Betsham House, London Bridge",
  category: "Power Tools",
  image_url: "https://www.protoolreviews.com/wp-content/uploads/2021/03/Skil-PWR-Core-20-Compact-Reciprocating-Saw04-800x534.jpg"
  },
  {
  name: "STIHL Chainsaw",
  description: "30.1 cm³ Engine
      12 Bar & Chain, RELIABLY USED 10years
      1.2 kW Power Output, Lightweight at 4.5 kg,
      Anti-Vibration System",
  price: 3500,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "24 Glenshaw Mansion, Oval, SW9 0DS",
  category: "Power Tools",
  image_url: "https://imagedelivery.net/ePR8PyKf84wPHx7_RYmEag/505f62d7-f989-436d-195d-74518a579200/86"
  },
  {
  name: "Welding Helmet",
  description: "ESAB Warrior Tech Auto Darkening Welding Helmet WITH Hard Hat Attachment",
  price: 6000,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "139 Rushton House, London",
  category: "Personal Protective Equipment",
  image_url: "https://5.imimg.com/data5/SELLER/Default/2024/3/399481305/FV/EI/QM/214718061/auto-darkening-helmet-1.jpeg"
  },
  {
  name: "Pressure Washer",
  description: "Titan TTB1800PRW Corded 140 Bar 1.8Kw Cold Water Pressure Washer (unit Only) No",
  price: 3900,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "60 Marina Place, Hampton Wick",
  category: "Outdoor Power Equipment",
  image_url: "https://cdn.thewirecutter.com/wp-content/media/2020/09/pressurewasher2020-2048-0698.jpg?auto=webp&quality=75&width=1024"
  },
  {
  name: "Angle Grinder",
  description: "Hitachi Gs23sr 230mm Angle Disc Grinder, recently REFURBISHED",
  price: 6700,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "139 Kingsland Road, Shoreditch",
  category: "Power Tools",
  image_url: "https://www.familyhandyman.com/wp-content/uploads/2024/02/FHMVS24_MR_01_04_24_AngleGrinder_2_How-to-Use-an-Angle-Grinder_FT.jpg"
  },
  {
  name: "Mitre Saw",
  description: "Tough, durable, compact and powerful sliding compound mitre saw. 250mm slide capacity. Features a highly durable back fence, mitre detents and bevel stops to provide accuracy on repeated cuts over the life of the saw.",
  price: 15000,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "9 Rosary Gardens, South Kensington",
  category: "Power Tools",
  image_url: "https://static.thcdn.com/productimg/960/960/14928225-4205170882099806.jpg"
  },
  {
  name: "Capentry Saw",
  description: "SUIZAN Japanese Pull Saw Hand Saw 150mm Dozuki Dovetail Saw Tenon Saw for Ultra Fine Cross Cut Rip Cut Angle Cut Woodworking Tools",
  price: 1500,
  available_from: Date.today,
  available_until: Date.today + 10,
  user: User.all.sample,
  address: "Old Compton St, London W1D 5JL",
  category: "Hand Tools",
  image_url: "https://i.shgcdn.com/7263803d-9d73-4452-8b2e-f0ef78c23dac/-/format/auto/-/preview/3000x3000/-/quality/lighter/"
  },
  {
  name: "Belt Sander",
  description: "Makita M9400 4 inch Electric Belt Sander 240V. Robust and reliable belt sander designed for competent home users, apprentices and part-time tradespeople.",
  price: 7600,
  available_from: Date.today + 5,
  available_until: Date.today + 25,
  user: User.all.sample,
  address: "Cannon Bridge House, 1 Cousin Lane, London EC4R 3TE",
  category: "Hand Tools",
  image_url: "https://www.heamar.co.uk/media/.renditions/wysiwyg/1_8.jpg"
  },
  {
  name: "Circular Saw",
  description: "Makita DSS611Z 18V Li-Ion LXT 165mm Circular Saw - Depth of cut at 90 degrees 57mm",
  price: 4100,
  available_from: Date.today + 5,
  available_until: Date.today + 25,
  user: User.all.sample,
  address: "Cannon Bridge House, 1 Cousin Lane, London EC4R 3TE",
  category: "Power Tools",
  image_url: "https://styla-prod-us.imgix.net/92314b9e-c171-46ba-b234-64ae64285741/1680693193142_5d8734d6-4fa4-4754-a41f-82e6bdf6be2c?auto=format%2Ccompress&w=1280&h=854&fit=crop&crop=faces%2Cedges&q=25"
  },
  {
  name: "Jigsaw",
  description: "DeWalt DCS331N 18V Li-Ion XR Cordless Jigsaw - Bare",
  price: 7600,
  available_from: Date.today + 5,
  available_until: Date.today + 25,
  user: User.all.sample,
  address: "Cannon Bridge House, 1 Cousin Lane, London EC4R 3TE",
  category: "Power Tools",
  image_url: "https://www.heamar.co.uk/media/.renditions/wysiwyg/1_8.jpg"
  }
]

seed_tools.each do |tool|
  Tool.create!(tool)
end

test_tool = Tool.new(
  name: "Magnusson Hammer",
  description: "Cross-pein hammer with ergnomic soft-grip handle and fibreglass shaft. Ideal for metalworking and great for tacks and pins.",
  price: 4000,
  available_from: Date.today + 4,
  available_until: Date.today + 12,
  user: test_user,
  address: "Buckingham Palace, London",
  category: "Hand Tools",
  image_url: "https://media.diy.com/is/image/Kingfisher/magnusson-carbon-steel-cross-pein-hammer-4oz-hm16~3663602817918_01i?$MOB_PREV$&$width=600&$height=600"
)
test_tool.save

puts "Seeded tools"

puts "Cleaning bookings DB"
Booking.destroy_all

puts "Seeding bookings DB"

5.times do
  booking = Booking.new(
    start_date: (Time.now + 2),
    end_date: (Time.now + 4),
    price: rand(100.1000),
    user: User.all.sample,
    tool: Tool.all.sample
  )
  booking.save
end

puts test_user.id

puts "Creating test booking"
test_booking = Booking.new(
  start_date: (Time.now + 2),
  end_date: (Time.now + 4),
  price: rand(100.1000),
  user: test_user,
  tool: test_tool
)
test_booking.save

puts "Seeded bookings DB"
puts "Seeding has been completed!"
puts "IMPORTANT: Test user login below..."
puts "email: test@test.com"
puts "username: #{test_user.username}"
puts "password: 123456"

# Faker::Appliance.equipment
# Faker::Appliance.brand
