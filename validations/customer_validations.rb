module Validations
  class CustomerValidation
    LIMIT_SCORE = 100_000
    LIMIT_ID = 1_000_000
    LIMIT_SIZE = 1_000_000

    def initialize(customer:)
      @id = customer[:id]
      @score = customer[:score]
    end

    def valid?
      id_inside_limit? && score_inside_limit?
    end

    def self.allowed_size(customers:)
      customers.size < LIMIT_SIZE
    end

    private

    attr_reader :id, :score

    def id_inside_limit?
      id.positive? && id < LIMIT_ID
    end

    def score_inside_limit?
      score.positive? && score < LIMIT_SCORE
    end
  end
end
