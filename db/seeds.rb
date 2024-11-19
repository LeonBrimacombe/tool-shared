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
require "nokogiri"
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
  password: "123456"
)
test_user.save

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    image: Faker::Avatar.image,
    username: Faker::Internet.user_name
  )
  user.save
end

puts "Users seeded!"

Tool.destroy_all
puts "Cleaning tools DB"

puts "Seeding user DB"

url = "https://www.productionequipment.com/hand-tools/tradesmans-tools.html"

html_file = URI.parse(url).read
html_doc = Nokogiri::HTML.parse(html_file)

tool_images = html_doc.search(".product-image-photo").map do |element|
  element.attribute("src").value
end

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
  "Hand Tools"]

20.times do
  tool = Tool.new(
    name: Faker::Appliance.equipment,
    description: Faker::Appliance.brand,
    price: rand(15..150),
    available_from: Time.now,
    available_until: (Time.now + 1),
    user: User.all.sample,
    image: tool_images.sample,
    address: Faker::Address,
    category: categories.sample,
  )
  tool.save
end

test_tool = Tool.new(
  name: Faker::Appliance.equipment,
  description: Faker::Appliance.brand,
  price: rand(100..1000),
  available_from: Time.now,
  available_until: (Time.now + 1),
  user: test_user
)
test_tool.save

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
puts "username: test@test.com"
puts "password: 123456"

# Faker::Appliance.equipment
# Faker::Appliance.brand
