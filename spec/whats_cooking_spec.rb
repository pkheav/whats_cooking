require './lib/whats_cooking'

describe WhatsCooking do
  it "should return the best recipes to cook based on items in the fridge csv list and their use by date" do
    whats_cooking = WhatsCooking.new('my-fridge.csv', 'my-recipes.json')
    expect(whats_cooking.recommend).to eq("Vegemite Sandwich")
  end
end
