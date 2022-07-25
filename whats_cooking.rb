require 'csv'

if ARGV.length != 2
  puts "Error: please pass the fridge csv list file as the first argument"
  puts "and the json recipe data file as the second argument"
  puts "See below for example usage"
  puts "ruby whats_cooking.rb my-fridge.csv my-recipes.json"
  exit
end

fridge_csv_list_file = ARGV[0]
json_recipe_data_file = ARGV[1]

puts ARGV[0]
puts ARGV[1]
