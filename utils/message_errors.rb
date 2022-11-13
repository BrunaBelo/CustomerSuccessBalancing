module Utils
  class MessageErrors
    def self.invalid_size_customers
      raise 'The number of customers must be less than 1.000.000'
    end

    def self.invalid_size_customer_success
      raise 'The number of customer success must be less than 1.000'
    end
  end
end
