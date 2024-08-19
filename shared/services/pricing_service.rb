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

    def calculate_discount
        total_price = calculate_price
        n = @rental.rental_duration
        base_price = @car.price_per_day
        discount = 0
    
        (1..n).each do |day|
          discount += case day
                      when 1
                        0
                      when 2..4
                        base_price * 0.1 # 10 % discount between day 2 and 4
                      when 5..10
                        base_price * 0.3 # 30 % discount between 5 and 10
                      else
                        base_price * 0.5 # 50 % discount after day 10
                      end
        end
        total_price - discount
    end
end