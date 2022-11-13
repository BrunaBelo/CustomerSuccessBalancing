require './validations/customer_validations.rb'

module Filters
  class FilterValidCustomers
    def initialize(customers:)
      @customers = customers
      @valid_customers = []
    end

    def filter
      filter_by_valid_customers

      valid_customers
    end

    private

    attr_accessor :customers, :valid_customers

    def filter_by_valid_customers
      @valid_customers = customers.select do |customer|
        customer_valid?(customer)
      end
    end

    def customer_valid?(customer)
      Validations::CustomerValidation.new(
        customer: customer
      ).valid?
    end
  end
end
