require 'date'

class Item
  def initialize(name, quantity, unit, use_by_date)
    @name = name
    # use .to_i to allow both string and integer values to be passed
    @quantity = quantity.to_i
    @unit = unit
    # Use Date.parse to allow more date formats to be be passed
    @date = Date.parse(use_by_date)
  end
end