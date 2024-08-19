# frozen_string_literal: true

require 'spec_helper'
require_relative '../../shared/models/rental'
require_relative '../../shared/models/car'
require_relative '../../shared/services/credit_debit_service'

RSpec.describe CreditDebitService do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:start_date) { '2015-12-8' }
  let(:end_date) { '2015-12-10' }
  let(:rental) { Rental.new(id: 1, car: car, start_date: start_date, end_date: end_date, distance: 100) }

  let(:credit_debit_service) { CreditDebitService.new(rental) }

  describe '#dispatch_credit_debit' do
    it 'dispatches credit and debit correctly' do
      credit_debit = credit_debit_service.dispatch_credit_debit

      expected_result = [
        { "who": 'driver', "type": 'debit', "amount": 6600 },
        { "who": 'owner', "type": 'credit', "amount": 4620 },
        { "who": 'insurance', "type": 'credit', "amount": 990 },
        { "who": 'assistance', "type": 'credit', "amount": 300 },
        { "who": 'drivy', "type": 'credit', "amount": 690 }
      ]
      expect(credit_debit).to eq(expected_result)
    end
  end
end
