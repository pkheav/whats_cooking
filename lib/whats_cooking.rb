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
    # Create a hash of all the items with the name as the key and item object as the value
    # for quicker referencing of items/ingredients
    @usable_items_by_name = {}
    today = Date.today
    # Filter out any items if it is passed their use by date as we can't use them
    items.each { |i| @usable_items_by_name[i.name] = i if i.use_by_date > today }

    recommended_recipe = nil
    earliest_recipe_use_by_date = nil
    recipes.each do |r|
      next unless recipe_use_by_date = recipe_possible?(r)

      recommended_recipe ||= r
      earliest_recipe_use_by_date ||= recipe_use_by_date

      if recipe_use_by_date < earliest_recipe_use_by_date
        recommended_recipe = r
        earliest_recipe_use_by_date = recipe_use_by_date
      end
    end

    # Suggest takeout if there isn't a recommended recipe
    recommended_recipe&.dig('name') || 'Call for takeout'
  end

  # Check if we have a usable item for every ingredient in the recipe
  # and return's the earliest use by date
  # returns nil otherwise
  def recipe_possible?(recipe)
    earliest_item_use_by_date = nil
    recipe['ingredients'].each do |i|
      # return nil as soon as we don't have an item needed by the recipe
      return unless item_use_by_date = usable_item?(i)
      earliest_item_use_by_date ||= item_use_by_date
      if item_use_by_date < earliest_item_use_by_date
        earliest_item_use_by_date = item_use_by_date
      end
    end
    earliest_item_use_by_date
  end

  # Takes in an ingredient from a recipe and returns the item's use by date if we have it
  # returns nil otherwise
  private def usable_item?(ingredient)
    return unless usable_item = @usable_items_by_name[ingredient['item']]
    usable_item.use_by_date if usable_item.quantity > ingredient['quantity'].to_f
  end
end
