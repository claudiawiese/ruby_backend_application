# frozen_string_literal: true

# This model initalizes Car object
class Car
    attr_accessor :id, :price_per_day, :price_per_km
  
    def initialize(attributes = {})
      @id = attributes[:id]
      @price_per_day = attributes[:price_per_day]
      @price_per_km = attributes[:price_per_km]
    end
end