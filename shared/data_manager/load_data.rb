# frozen_string_literal: true

require 'json'
require_relative '../models/car'
require_relative '../models/rental'

# This class is in charge of loading data from input.json
class LoadData
  def self.load_data(file_path)
    file = File.read(file_path)
    data = JSON.parse(file)

    cars = data['cars'].map do |car_data|
      Car.new(id: car_data['id'], price_per_day: car_data['price_per_day'], price_per_km: car_data['price_per_km'])
    end

    cars_by_id = cars.map { |car| [car.id, car] }.to_h

    data['rentals'].map do |rental_data|
      car = cars_by_id[rental_data['car_id']]
      Rental.new(id: rental_data['id'], car: car, start_date: rental_data['start_date'],
                 end_date: rental_data['end_date'], distance: rental_data['distance'])
    end
  end
end