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
  
    def dispatch_credit_debit_with_options
      option_prices = @pricing_service.calculate_options_price
      transactions = dispatch_credit_debit
  
      # add total of option to rental price for the driver
      transactions[0][:amount] += option_prices[:gps] + option_prices[:baby_seat] + option_prices[:additional_insurance]
  
      # add gps and baby_seat prices to owner_fee
      transactions[1][:amount] += option_prices[:gps] + option_prices[:baby_seat]
  
      # add additional insurance prce to drivy_fee
      transactions[4][:amount] += option_prices[:additional_insurance]
      transactions
    end
end