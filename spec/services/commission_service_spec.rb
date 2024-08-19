# frozen_string_literal: true

require 'spec_helper'
require_relative '../../shared/models/rental'
require_relative '../../shared/models/car'
require_relative '../../shared/services/commission_service'

RSpec.describe CommissionService do
  let(:car) { Car.new(id: 1, price_per_day: 1000, price_per_km: 10) }
  let(:start_date) { '2015-12-8' }
  let(:end_date) { '2015-12-8' }
  let(:rental) { Rental.new(id: 1, car: car, start_date: start_date, end_date: end_date, distance: 100) }

  let(:commission_service) { CommissionService.new(rental) }

  describe '#calculate_commission' do
    context 'when rental duration is 1 day' do
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(300.0)
        expect(commission[:assistance_fee]).to eq(100)
        expect(commission[:drivy_fee]).to eq(200.0)
      end
    end

    context 'when rental duration is 3 days' do
      let(:end_date) { '2015-12-10' }
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(570)
        expect(commission[:assistance_fee]).to eq(300)
        expect(commission[:drivy_fee]).to eq(270)
      end
    end

    context 'when rental duration is 4 days' do
      let(:end_date) { '2015-12-11' }
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(705)
        expect(commission[:assistance_fee]).to eq(400)
        expect(commission[:drivy_fee]).to eq(305)
      end
    end

    context 'when rental duration is 5 days' do
      let(:end_date) { '2015-12-12' }
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(810)
        expect(commission[:assistance_fee]).to eq(500)
        expect(commission[:drivy_fee]).to eq(310)
      end
    end

    context 'when rental duration is 10 days' do
      let(:end_date) { '2015-12-17' }
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(1335)
        expect(commission[:assistance_fee]).to eq(1000)
        expect(commission[:drivy_fee]).to eq(335)
      end
    end

    context 'when rental duration is 11 days' do
      let(:end_date) { '2015-12-18' }
      it 'calculates correct commission fees' do
        commission = commission_service.calculate_commission
        expect(commission[:insurance_fee]).to eq(1410)
        expect(commission[:assistance_fee]).to eq(1100)
        expect(commission[:drivy_fee]).to eq(310)
      end
    end
  end
end
