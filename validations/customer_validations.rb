module Validations
  class CustomerValidation
    LIMIT_SIZE = 100_000
    LIMIT_ID = 1_000_000

    def initialize(costumer:)
      @id = costumer[:id]
      @score = costumer[:score]
    end

    def valid?
      id_inside_limit? && score_inside_limit?
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
