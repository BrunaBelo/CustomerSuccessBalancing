require './core/validations/customer_success_validation.rb'

module Filters
  class FilterValidsCustomerSuccess
    def initialize(customer_success:, away_customer_success:)
      @customer_success = customer_success
      @away_customer_success = away_customer_success
      @valid_customer_success = []
    end

    def filter
      filter_by_valids_customer_success
      filter_by_uniquenes_score

      sort_by_score
    end

    private

    attr_accessor :valid_customer_success, :away_customer_success,
                  :customer_success

    def filter_by_valids_customer_success
      @valid_customer_success = customer_success.select do |current_customer_success|
        customer_success_valid?(current_customer_success)
      end
    end

    def filter_by_uniquenes_score
      @valid_customer_success = valid_customer_success.uniq do |customer_success|
        customer_success[:score]
      end
    end

    def customer_success_valid?(current_customer_success)
      Validations::CustomerSuccessValidation.new(
        customer_success: current_customer_success,
        away_customer_success: away_customer_success
      ).valid?
    end

    def sort_by_score
      valid_customer_success.sort_by do |current_customer_success|
        current_customer_success[:score]
      end
    end
  end
end
