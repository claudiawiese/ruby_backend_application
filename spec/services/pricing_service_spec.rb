# frozen_string_literal: true

require 'spec_helper'
require_relative '../../shared/models/rental'
require_relative '../../shared/models/car'
require_relative '../../shared/services/pricing_service'

RSpec.describe PricingService do
  let(:car) { Car.new(id: 1, price_per_day: 100, price_per_km: 10) }
  let(:start_date) { '2015-12-8' }
  let(:end_date) { '2015-12-8' }
  let(:rental) { Rental.new(id: 1, car: car, start_date: start_date, end_date: end_date, distance: 100) }

  let(:pricing_service) { PricingService.new(rental) }

  describe '#calculate_rental_price' do
    context 'when rental duration is 1 day' do
      it 'calculates correct rental price' do
        result = pricing_service.calculate_price
        expect(result).to eq(1100)
      end
    end

    context 'when rental duration is 3 days' do
      let(:end_date) { '2015-12-10' }
      it 'calculates correct rental_price' do
        result = pricing_service.calculate_price
        expect(result).to eq(1300)
      end
    end
  end

  describe '#calculate_discount' do
    context 'when rental duration is 1 day' do
      it 'calculates correct rental price with discount' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1100.0)
      end
    end

    context 'when rental duration is 3 days' do
      let(:end_date) { '2015-12-10' }
      it 'calculates correct rental_price with discount' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1280.0)
      end
    end

    context 'when rental duration is 4 days' do
      let(:end_date) { '2015-12-11' }
      it 'calculates correct rental_price with discount' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1370.0)
      end
    end

    context 'when rental duration is 5 days' do
      let(:end_date) { '2015-12-12' }
      it 'calculates correct rental_price with discount' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1440.0)
      end
    end

    context 'when rental duration is 10 days' do
      let(:end_date) { '2015-12-17' }
      it 'calculates correct discount_price for 10 days' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1790.0)
      end
    end

    context 'when rental duration is 11 days' do
      let(:end_date) { '2015-12-18' }
      it 'calculates correct rental_price with discount' do
        result = pricing_service.calculate_discount
        expect(result).to eq(1840.0)
      end
    end
  end
end 