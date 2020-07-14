class OysterCard
  attr_reader :balance, :in_use

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "card limit: #{CARD_LIMIT} reached" if amount > CARD_LIMIT

    @balance += amount
    "topped up #{amount}"
  end

  def deduct(amount)
    @balance -= amount
    "#{amount} deducted"
  end

  def touch_in
    raise "minimum limit: #{MINIMUM_FARE} required" if balance < MINIMUM_FARE

      @in_use = true
      "Touch-in successful"
  end

  def touch_out
    @in_use = false
    "Touch-out successful"
  end

  def in_journey?
    @in_use
  end
end
