require './lib/whats_cooking'

if ARGV.length != 2
  puts 'Error: please pass the fridge csv list file as the first argument'
  puts 'and the json recipe data file as the second argument'
  puts 'See below for example usage'
  puts 'ruby main.rb my-fridge.csv my-recipes.json'
  exit
end

# * is the splat operator and allows an array to be unpacked
# so it can be passed as args to a function
whats_cooking = WhatsCooking.new(*ARGV)

puts whats_cooking.items.inspect
puts whats_cooking.recipes
puts whats_cooking.recommend
