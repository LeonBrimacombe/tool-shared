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

require "open-uri"
# require "nokogiri"
require "faker"

# 2) Prepare tags and import, then parse file into results array.

# url = "https://www.enchantedlearning.com/wordlist/tools.shtml"
# html_tag = "wordlist_item"
# tools_file = URI.open(url).read
# p "Opened file"
# tools_doc = Nokogiri::HTML(tools_file)
# p "Parsed file"

# search_results = tools_doc.search(html_tag)

# What does the database need.... It needs users, with tools, with bookings.

puts "Cleaning user database"
User.destroy_all

puts "Seeding user DB"
test_user = User.new(
  email: "test@test.com",
  password: "123456",
  username: Faker::Internet.user_name
)
test_user.save

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    username: Faker::Internet.user_name
  )
  user.save
end

User.all.each do |user|
  profile_url = "https://res.cloudinary.com/dn2pd6off/image/upload/v1732101103/DALL_E_2024-11-20_11.05.49_-_A_square_2D_cartoonish_illustration_of_a_robot_handyman_in_a_black_and_orange_theme._The_robot_has_a_friendly_and_playful_design_with_a_simple_smiley_-3_fna7rh.jpg"
  user.image.attach(
    io: URI.open(profile_url),
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

20.times do
  tool = Tool.new(
    name: Faker::Appliance.equipment,
    description: Faker::Appliance.brand,
    price: rand(100..10000),
    available_from: Time.now,
    available_until: (Time.now + 1),
    user: User.all.sample,
    address: Faker::Address.street_address,
    category: categories.sample
  )
  puts tool
  tool.save
end

test_tool = Tool.new(
  name: Faker::Appliance.equipment,
  description: Faker::Appliance.brand,
  price: rand(100..10000),
  available_from: Time.now,
  available_until: (Time.now + 1),
  user: test_user,
  address: Faker::Address.street_address,
  category: categories.sample
)
test_tool.save

Tool.all.each do |tool|
  tools_urls = [
    "https://res.cloudinary.com/dn2pd6off/image/upload/v1732101103/DALL_E_2024-11-20_11.02.32_-_A_wide_aspect_ratio_2D_cartoonish_illustration_of_a_single_hammer_in_a_black_and_orange_theme._The_hammer_is_prominently_centered_featuring_a_playful-2_a1gkcn.jpg",
    "https://res.cloudinary.com/dn2pd6off/image/upload/v1732101104/DALL_E_2024-11-20_11.04.39_-_A_wide_aspect_ratio_2D_cartoonish_illustration_of_a_single_lawnmower_in_a_black_and_orange_theme._The_lawnmower_is_prominently_centered_featuring_a_p-2_jnfoeq.jpg",
    "https://res.cloudinary.com/dn2pd6off/image/upload/v1732101103/DALL_E_2024-11-20_11.03.10_-_A_wide_aspect_ratio_2D_cartoonish_illustration_of_a_single_chainsaw_in_a_black_and_orange_theme._The_chainsaw_is_prominently_centered_featuring_a_pla-2_mcjxzs.jpg"
  ]
  tool.images.attach(
    io: URI.open(tools_urls.sample),
    filename: "tool.jpg",
    content_type: "image/jpeg"
  )
  tool.save!
end

puts "Seeded tools"

puts "Cleaning bookings DB"
Booking.destroy_all

puts "Seeding bookings DB"

20.times do
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
