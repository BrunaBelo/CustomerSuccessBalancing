require './filters/filter_valids_customer_success.rb'
require './filters/filter_valid_customers.rb'
require './utils/message_errors.rb'
require './validations/customer_success_validation.rb'
require './validations/customer_validations.rb'

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

    valid_customer_success
    valid_customers
  end

  private

  attr_reader :customer_success, :away_customer_success, :customers

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

  def message_errors
    @message_errors ||= Utils::MessageErrors
  end
end
