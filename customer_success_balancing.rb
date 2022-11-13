require './filters/filter_valids_costumer_success.rb'

class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  # Returns the ID of the customer success with most customers
  def execute
    valid_customer_success
  end

  private

  attr_reader :customer_success, :away_customer_success

  def valid_customer_success
    @valid_customer_success ||= Filters::FilterValidsCostumerSuccess.new(
      customer_success: customer_success,
      away_customer_success: away_customer_success
    ).filter
  end
end
