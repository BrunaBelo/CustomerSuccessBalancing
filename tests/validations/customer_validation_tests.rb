require 'minitest/autorun'
require './validations/customer_success_validation.rb'

module Validations
  class CustomerValidationTest < Minitest::Test
    def test_allowed_id
      validator = described_class.new(
        costumer_success: { id: 10, score: 10 }
      )
      assert_equal true, validator.valid?
    end

    def test_negative_id
      validator = described_class.new(
        costumer_success: { id: -10, score: 10 }
      )
      assert_equal false, validator.valid?
    end

    def test_id_biggest_then_limit
      validator = described_class.new(
        costumer_success: { id: 2_000_000, score: 10 }
      )
      assert_equal false, validator.valid?
    end

    def test_id_zero
      validator = described_class.new(
        costumer_success: { id: 0, score: 10 }
      )
      assert_equal false, validator.valid?
    end

    def test_allowed_score
      validator = described_class.new(
        costumer_success: { id: 10, score: 10 }
      )
      assert_equal true, validator.valid?
    end

    def test_negative_score
      validator = described_class.new(
        costumer_success: { id: 10, score: -10 }
      )
      assert_equal false, validator.valid?
    end

    def test_score_biggest_then_limit
      validator = described_class.new(
        costumer_success: { id: 10, score: 200_000 }
      )
      assert_equal false, validator.valid?
    end

    def test_score_zero
      validator = described_class.new(
        costumer_success: { id: 10, score: 0 }
      )
      assert_equal false, validator.valid?
    end

    private

    def described_class
      Validations::CustomerSuccessValidation
    end
  end
end
