require 'minitest/autorun'
require 'timeout'
require './filters/filter_valids_costumer_success.rb'

class Filters::FilterValidsCostumerSuccessTests < Minitest::Test
  def test_allowed_ids_filter
    filter = described_class.new(
      customer_success: [
        { id: 10, score: 10 },
        { id: 200_000, score: 20 },
        { id: 3, score: 30_000 }
      ],
      away_customer_success: []
    )
    assert_equal [{ id: 10, score: 10 }], filter.filter
  end

  def test_without_away_cs
    filter = described_class.new(
      customer_success: [
        { id: 1, score: 1 },
        { id: 10, score: 10 },
        { id: 200_000, score: 20 },
        { id: 3, score: 30_000 }
      ],
      away_customer_success: [10]
    )
    assert_equal [{ id: 1, score: 1 }], filter.filter
  end

  private

  def described_class
    Filters::FilterValidsCostumerSuccess
  end
end