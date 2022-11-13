module Filters
  class FilterMostRequestedCustomerSuccess
    def initialize(customer_success:)
      @customer_success = customer_success
    end

    def filter
      customer_success_with_more_customers
    end

    private

    attr_reader :customer_success

    def customer_success_with_more_customers
      sorted_customer_success = sort_by_score_desc

      return 0 if a_tie?(sorted_customer_success)

      sorted_customer_success.first[:id]
    end

    def sort_by_score_desc
      customer_success.sort_by do |current_customer_success|
        current_customer_success[:quantity_customers]
      end.reverse!
    end

    def a_tie?(sorted_customer_success)
      sorted_customer_success[0][:quantity_customers] ==
        sorted_customer_success[1][:quantity_customers]
    end
  end
end
