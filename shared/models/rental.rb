# frozen_string_literal: true

require 'date'
require_relative '../services/pricing_service'

# This model initalizes Rental object
class Rental
  attr_accessor :id, :car, :start_date, :end_date, :distance, :options

  def initialize(attributes = {})
    @id = attributes[:id]
    @car = attributes[:car]
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @distance = attributes[:distance]
    @options = attributes[:options] || []
  end

  def rental_duration
    start_date = Date.parse(@start_date)
    end_date = Date.parse(@end_date)
    (end_date - start_date).to_i + 1
  end

  def display_rental_price
    PricingService.new(self).calculate_price
  end

  def display_discount
    PricingService.new(self).calculate_discount
  end

end