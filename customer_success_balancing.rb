require './filters/filter_valids_customer_success.rb'
require './filters/filter_valid_customers.rb'
require './filters/filter_customer_success_with_more_customers.rb'
require './validations/customer_success_validation.rb'
require './validations/customer_validations.rb'
require './utils/message_errors.rb'

class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  # Returns the ID of the customer success with most customers
  def execute
    return message_errors.invalid_size_customer_success unless customers_success_allowed_size?
    return message_errors.invalid_size_customers unless customers_allowed_size?

    balance_customer_success
    customer_success_with_more_customers
  end

  private

  attr_reader :customer_success, :away_customer_success, :customers

  def balance_customer_success
    generate_default_quantity_custumers

    valid_customers.each do |customer|
      selected_customer_success = select_customer_success(customer)

      if selected_customer_success.any?
        selected_customer_success.first[:quantity_customers] += 1
      end
    end
  end

  def select_customer_success(customer)
    valid_customer_success.select do |current_customer_success|
      current_customer_success[:score] >= customer[:score]
    end
  end

  def customer_success_with_more_customers
    sorted_customer_success = valid_customer_success.sort_by do |cs|
      cs[:quantity_customers]
    end.reverse!

    return 0 if a_tie?(sorted_customer_success)

    sorted_customer_success[0][:id]
  end

  def valid_customer_success
    @valid_customer_success ||= Filters::FilterValidsCustomerSuccess.new(
      customer_success: customer_success,
      away_customer_success: away_customer_success
    ).filter
  end

  def valid_customers
    @valid_customers ||= Filters::FilterValidCustomers.new(
      customers: customers
    ).filter
  end

  def customers_allowed_size?
    Validations::CustomerValidation.allowed_size(customers: customers)
  end

  def customers_success_allowed_size?
    Validations::CustomerSuccessValidation.allowed_size(
      customer_success_list: customer_success
    )
  end

  def generate_default_quantity_custumers
    valid_customer_success.each do |current_customer_success|
      current_customer_success[:quantity_customers] = 0
    end
  end

  def message_errors
    @message_errors ||= Utils::MessageErrors
  end

  def a_tie?(sorted_customer_success)
    sorted_customer_success[0][:quantity_customers] ==
      sorted_customer_success[1][:quantity_customers]
  end
end
