# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'bcrypt'

ActiveRecord::Base.connection.tables.each do |table|
  if table != "ar_internal_metadata" && table != "schema_migrations"
    puts "Resetting auto increment ID for #{table} to 1"
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH 1")
  end
end
Picture.destroy_all
User.destroy_all

users_array = []
pictures_array = []

Faker::Config.locale = 'en-US'

puts "\nCréation de l'admin du site : un utilisateur de prénom, de nom et de password \"Anonymous\", qui a pour email \"anonymous@yopmail.com\"."
anonymous_user = User.new(first_name: "Anonymous",
                          last_name: "Anonymous",
                          description: "Utilisateur créé afin qu'il soit l'administrateur du site.",
                          email: "anonymous@yopmail.com",
                          encrypted_password: BCrypt::Password.create("Anonymous")
                         )
anonymous_user.save!(:validate => false)
users_array << anonymous_user

puts "\nGénération plus aléatoire :"

n = 3

n.times do |index|
  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.unique.last_name
  email = "#{first_name.gsub(' ', '').downcase}_#{last_name.gsub(' ', '').downcase}@yopmail.com"
  password = Faker::Internet.password(min_length: 6, max_length: 10)
  puts "\nLe password du #{index + 2}-ième utilisateur - de prénom \"#{first_name.capitalize}\", de nom \"#{last_name.capitalize}\" et d'email \"#{email}\" - créé par ce seed sera : \"#{password}\"."
  user = User.new(first_name: "#{first_name.capitalize}",
                  last_name: "#{last_name.capitalize}",
                  description: ("#{first_name.capitalize} #{last_name.capitalize} est une #{index + 2}-ième personne (de password \"#{password}\") : " + Faker::Lorem.characters(number: 15)),
                  email: "#{email}",
                  encrypted_password: BCrypt::Password.create(password)
                 )
  user.save!(:validate => false)
  users_array << user

  picture = Picture.create(title: "Photo n°#{index + 1}",
                           description: "Photo de chaton(s) fictive créée par seed.",
                           price: Faker::Number.between(from: 1, to: 1000),
                           img_url: Faker::Internet.url
                          )
  pictures_array << picture
end

require 'table_print'

tp.set User, :id, :first_name, :last_name, :email, :encrypted_password, :description
puts "#{users_array.length} users créés :\n"
tp User.all

tp.set Picture, :id,
                {title: {:width => 13}},
                {description: {:width => 70}},
                {price: {:width => 5}},
                {img_url: {:width => 170}}
puts "\n#{pictures_array.length} photos créées :\n"
tp Picture.all
