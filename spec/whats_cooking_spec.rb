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
      whats_cooking = WhatsCooking.new('my-fridge-one-bread.csv', 'my-recipes.json')
      expect(whats_cooking.recommend).to eq('Call for takeout')
    end
  end

  context "when we have expired vegemite and expired peanut butter" do
    it "should suggest getting takeout" do
      whats_cooking = WhatsCooking.new('my-fridge-expired-spreads.csv', 'my-recipes.json')
      expect(whats_cooking.recommend).to eq('Call for takeout')
    end
  end

  context "when we have enough ingredients for both recipes but peanut butter is the closest to expiring" do
    it "should return Toasted Cheese as the recommended recipe" do
      whats_cooking = WhatsCooking.new('my-fridge-peanut-almost-expired.csv', 'my-recipes.json')
      expect(whats_cooking.recommend).to eq('Peanut Butter Sandwich')
    end
  end
end
