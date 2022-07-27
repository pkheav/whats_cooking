require './lib/whats_cooking'

describe WhatsCooking do
  context "when we don't have enough cheese in the fridge but enough bread and vegemite" do
    it "should return Vegemite Sandwich as the recommended recipe" do
      whats_cooking = WhatsCooking.new('my-fridge.csv', 'my-recipes.json')
      expect(whats_cooking.recommend).to eq('Vegemite Sandwich')
    end
  end

  context "when we don't have enough bread in the fridge for either sandwich recipes" do
    it "should suggest getting takeout" do
      whats_cooking = WhatsCooking.new('my-fridge2.csv', 'my-recipes.json')
      expect(whats_cooking.recommend).to eq('Call for takeout')
    end
  end
end
