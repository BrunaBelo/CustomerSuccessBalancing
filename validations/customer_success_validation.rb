module Validations
  class CustomerSuccessValidation
    LIMIT_SCORE = 10_000
    LIMIT_ID = 1000
    LIMIT_SIZE = 1000

    def initialize(costumer_success:, away_customer_success: [])
      @id = costumer_success[:id]
      @score = costumer_success[:score]
      @away_customer_success = away_customer_success
    end

    def valid?
      id_inside_limit? &&
        score_inside_limit? &&
        available_customer_success?
    end

    def self.allowed_size(costumer_success_list:)
      costumer_success_list.size < LIMIT_SIZE
    end

    private

    attr_reader :id, :score, :away_customer_success

    def id_inside_limit?
      id.positive? && id < LIMIT_ID
    end

    def score_inside_limit?
      score.positive? && score < LIMIT_SCORE
    end

    def available_customer_success?
      return true if away_customer_success.empty?

      !away_customer_success.include?(id)
    end
  end
end
