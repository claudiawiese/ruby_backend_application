# frozen_string_literal: true

# This service is in charge of dispatching credit and debit amounts
class CreditDebitService
    def initialize(rental)
      @pricing_service = PricingService.new(rental)
      @commission_service = CommissionService.new(rental)
    end
  
    def dispatch_credit_debit
      rental_price = @pricing_service.calculate_discount
      owner_fee = rental_price - (rental_price * 0.3) # owner receives difference between rental_price and commission
      commission = @commission_service.calculate_commission
      [
        { "who": 'driver', "type": 'debit', "amount": rental_price },
        { "who": 'owner', "type": 'credit', "amount": owner_fee },
        { "who": 'insurance', "type": 'credit', "amount": commission[:insurance_fee] },
        { "who": 'assistance', "type": 'credit', "amount": commission[:assistance_fee] },
        { "who": 'drivy', "type": 'credit', "amount": commission[:drivy_fee] }
      ]
    end
end