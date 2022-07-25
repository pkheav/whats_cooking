require 'csv'
require 'json'
require './item'

if ARGV.length != 2
  puts "Error: please pass the fridge csv list file as the first argument"
  puts "and the json recipe data file as the second argument"
  puts "See below for example usage"
  puts "ruby whats_cooking.rb my-fridge.csv my-recipes.json"
  exit
end

items = CSV.read(ARGV[0]).collect { |row| Item.new(*row) }
puts items.inspect

json_recipe_data_file = File.read(ARGV[1])
puts recipes = JSON.parse(json_recipe_data_file)
