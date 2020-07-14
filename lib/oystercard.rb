require_relative 'station'
class OysterCard
  attr_reader :balance, :entry_station, :exit_station

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

  def touch_in(station)
    raise "minimum limit: #{MINIMUM_FARE} required" if balance < MINIMUM_FARE

      @in_use = true
      @entry_station = station
      "Touch-in successful"
  end

  def touch_out(station)
    @in_use = false
    @exit_station = station
    @entry_station = nil
    deduct(MINIMUM_FARE)
    "Touch-out successful"
  end

  def in_journey?
    entry_station != nil ? true : false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
