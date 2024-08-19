# frozen_string_literal: true

# This service is in charge of calculating commissions
class CommissionService
    def initialize(rental)
      @rental = rental
      @pricing_service = PricingService.new(rental)
    end
  
    def calculate_commission
      rental_price = @pricing_service.calculate_discount
      commission = rental_price * 0.3
      insurance = commission / 2
      assistance = @rental.rental_duration * 100
      drivy = commission - (insurance + assistance)
  
      {
        insurance_fee: insurance,
        assistance_fee: assistance,
        drivy_fee: drivy
      }
    end
  end