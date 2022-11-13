require 'minitest/autorun'
require './filters/filter_valid_customers.rb'

module Filters
  class FilterValidCustomersTests < Minitest::Test
    def test_allowed_ids_filter
      filter = described_class.new(
        customers: [
          { id: 10, score: 10 },
          { id: 1_000_010, score: 20 },
          { id: 3, score: 100_010 }
        ]
      )
      assert_equal [{ id: 10, score: 10 }], filter.filter
    end

    private

    def described_class
      Filters::FilterValidCustomers
    end
  end
end
