# frozen_string_literal: true

# This model initalizes Option object
class Option
    attr_accessor :id, :rental_id, :type
  
    def initialize(attributes = {})
      @id = attributes[:id]
      @rental_id = attributes[:rental_id]
      @type = attributes[:type]
    end
  end