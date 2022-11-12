
class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  # Returns the ID of the customer success with most customers
  def execute
    available_customer_success
  end

  private

  attr_reader :customer_success, :away_customer_success

  def available_customer_success
    customer_success.reject do |current_customer_success|
      away_customer_success.include?(current_customer_success[:id])
    end
  end
end
