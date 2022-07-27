require 'date'

class Item
  attr_accessor :name, :quantity, :unit, :use_by_date

  def initialize(name, quantity, unit, use_by_date)
    @name = name
    # use .to_i to allow string, float and integer values to be passed in
    @quantity = quantity.to_f
    @unit = unit
    # Use Date.parse to allow more date formats to be be passed in
    @use_by_date = Date.parse(use_by_date)
  end
end