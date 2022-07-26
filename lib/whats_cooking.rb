require 'csv'
require 'json'
require_relative './item'

class WhatsCooking
  attr_accessor :items, :recipes

  def initialize(csv_file_path, json_recipe_data_file_path)
    @items = self.class.csv_file_to_items(csv_file_path)
    @recipes = self.class.json_file_to_recipes(json_recipe_data_file_path)
  end

  # Read the fridge csv list file and convert it into an aray of items
  def self.csv_file_to_items(csv_file_path)
    CSV.read(ARGV[0]).collect { |row| Item.new(*row) }
  end

  def self.json_file_to_recipes(json_recipe_data_file_path)
    JSON.parse(File.read(json_recipe_data_file_path))
  end
end
