require 'csv'
require 'json'
require_relative './item'

# The distinction between ingredients and items are:
# ingredients are items that are required and specified in the recipe
# whereas items are what we actually have on hand in the fridge
class WhatsCooking
  attr_accessor :items, :recipes

  def initialize(csv_file_path, json_recipe_data_file_path)
    @items = self.class.csv_file_to_items(csv_file_path)
    @recipes = self.class.json_file_to_recipes(json_recipe_data_file_path)
  end

  # Read the fridge csv list file and convert it into an array of items
  def self.csv_file_to_items(csv_file_path)
    CSV.read(csv_file_path).collect { |row| Item.new(*row) }
  end

  def self.json_file_to_recipes(json_recipe_data_file_path)
    JSON.parse(File.read(json_recipe_data_file_path))
  end

  def recommend
    # Default recipe that will be recommended if there are no possible recipes
    recommended_recipe = 'Call for takeout'
    # Create a hash of all the items with the name as the key and item object as the value
    # for quicker referencing of items/ingredients
    @usable_items_by_name = {}
    today = Date.today
    # Filter out any items if it is passed their use by date as we can't use them
    items.each { |i| @usable_items_by_name[i.name] = i if i.use_by_date > today }

    recommended_recipe
  end

  # Check if we have a usable item for every ingredient in the recipe
  def possible_recipe?(recipe)
    recipe['ingredients'].all? { |i| usable_item?(i) }
  end

  # Takes in an ingredient from a recipe and returns whether or not we have a usable item for it
  private def usable_item?(ingredient)
    puts ingredient['item']
    puts @usable_items_by_name[ingredient['item']]
    @usable_items_by_name[ingredient['item']]
  end
end
