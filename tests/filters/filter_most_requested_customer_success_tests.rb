require 'minitest/autorun'
require './filters/filter_most_requested_customer_success.rb'

module Filters
  class FilterMostRequestedCustomerSuccessTest < Minitest::Test
    def test_customer_success_more_customers
      filter = described_class.new(
        customer_success: [
          { id: 1, score: 10, quantity_customers: 10 },
          { id: 2, score: 20, quantity_customers: 30 },
          { id: 3, score: 30, quantity_customers: 15 }
        ]
      )
      assert_equal 2, filter.filter
    end

    def test_a_tie
      filter = described_class.new(
        customer_success: [
          { id: 1, score: 10, quantity_customers: 10 },
          { id: 2, score: 20, quantity_customers: 30 },
          { id: 3, score: 30, quantity_customers: 30 }
        ]
      )
      assert_equal 0, filter.filter
    end

    private

    def described_class
      Filters::FilterMostRequestedCustomerSuccess
    end
  end
end
