# frozen_string_literal: true

# This service is in charge of calculating rental prices
class PricingService
    def initialize(rental)
      @rental = rental
      @car = rental.car
      raise "Car with id #{rental.car_id} not found." unless @car
    end
  
    def calculate_price
      fixed_price = @car.price_per_day * @rental.rental_duration
      variable_price = @car.price_per_km * @rental.distance
      fixed_price + variable_price
    end
end