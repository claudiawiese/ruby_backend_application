require 'spec_helper'
require_relative '../../shared/models/rental'

RSpec.describe Rental do
  let(:start_date) { '2015-12-8' }
  let(:end_date) { '2015-12-8' }
  let(:rental) { Rental.new(id: 1, car: 'car_object', start_date: start_date, end_date: end_date, distance: 100) }

  describe '#rental_duration' do
    context 'when rental duration is 1 day' do
      it 'calculates correct duration' do
        expect(rental.rental_duration).to eq(1)
      end
    end

    context 'when rental duration is 3 days' do
      let(:end_date) { '2015-12-10' }
      it 'calculates correct duration' do
        expect(rental.rental_duration).to eq(3)
      end
    end
  end
end