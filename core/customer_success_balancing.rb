require './core/filters/filter_valids_customer_success.rb'
require './core/filters/filter_valid_customers.rb'
require './core/filters/filter_most_requested_customer_success.rb'
require './core/validations/customer_success_validation.rb'
require './core/validations/customer_validations.rb'
require './utils/message_errors.rb'

class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  # Returns the ID of the customer success with most customers
  def execute
    return Utils::MessageErrors.invalid_size_customer_success unless customers_success_allowed_size?
    return Utils::MessageErrors.invalid_size_customers unless customers_allowed_size?

    customer_success_with_more_customers
  end

  private

  attr_reader :customer_success, :away_customer_success, :customers

  def customer_success_with_more_customers
    balance_customer_success

    Filters::FilterMostRequestedCustomerSuccess.new(
      customer_success: valid_customer_success
    ).filter
  end

  def balance_customer_success
    generate_default_quantity_custumers

    valid_customers.each do |customer|
      selected_customer_success = select_best_customer_success_to_customer(customer)

      if selected_customer_success
        selected_customer_success[:quantity_customers] += 1
      end
    end
  end

  def generate_default_quantity_custumers
    valid_customer_success.each do |current_customer_success|
      current_customer_success[:quantity_customers] = 0
    end
  end

  def select_best_customer_success_to_customer(customer)
    valid_customer_success.find do |current_customer_success|
      current_customer_success[:score] >= customer[:score]
    end
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
    Validations::CustomerValidation.allowed_size?(customers: customers)
  end

  def customers_success_allowed_size?
    Validations::CustomerSuccessValidation.allowed_size?(
      customer_success_list: customer_success
    )
  end
end
