module RewardScenario
  class CacheBack < Default
    delegate :transactions, to: :user
    REQUIRED_AMOUNT = 100
    REQUIRED_SIZE = 10

    private

    def condition?
      transactions.greater_than(REQUIRED_AMOUNT).count > REQUIRED_SIZE
    end

  end
end