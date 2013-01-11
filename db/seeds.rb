# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

puts "Seeding: Countries"
Country.delete_all
open("C:/Users/Usuario/Documents/GitHub/BTA/db/paises.csv") do |countries|
  countries.read.each_line do |country|
    name, id = country.chomp.split(";")
    Country.create!(:name => name)
  end
end

puts "Seeding: Cities"
City.delete_all
open("C:/Users/Usuario/Documents/GitHub/BTA/db/ciudades.csv") do |cities|
  cities.read.each_line do |city|
    name, id, country_name, country_id = city.chomp.split(";")
    City.create!(:name => name, :country_id => country_id)
  end
end

puts "Seeding: Airports"
Airport.delete_all
open("C:/Users/Usuario/Documents/GitHub/BTA/db/aeropuertos.csv") do |airports|
  airports.read.each_line do |airport|
    key, name, distance, country_name, country_id, city_name, city_id = airport.chomp.split(";")
    Airport.create!(:name => name, :key => key, :km_to_city => distance, :city_id => city_id)
  end
end

puts "Seeding: Airlines"
Airline.delete_all
open("C:/Users/Usuario/Documents/GitHub/BTA/db/aerolineas.csv") do |airlines|
  airlines.read.each_line do |airline|
    name, key, alt_key, country_name = airline.chomp.split(";")
    Airline.create!(:name => name, :key => key)
  end
end
