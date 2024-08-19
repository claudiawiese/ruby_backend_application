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

  def calculate_options_price
    duration = @rental.rental_duration
    prices = { gps: 0, baby_seat: 0, additional_insurance: 0 }

    @rental.options.each do |option|
      # gps: 5€ per day => total price:  5 * rental_duraton
      prices[:gps] += (5 * duration) if option.type == 'gps'

      # baby_seat: 2€ per day => total price: 2 * rental_duraton
      prices[:baby_seat] += 2 * duration if option.type == 'baby_seat'

      # additional_insurance: 10€ per day => total price: 10 * rental_duration
      prices[:additional_insurance] += 10 * duration if option.type == 'additional_insurance'
    end
    prices
  end
end