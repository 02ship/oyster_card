require_relative 'station'
class OysterCard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
    @journeys = []
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
    add_journey
    @entry_station = nil
    deduct(MINIMUM_FARE)
    "Touch-out successful"
  end

  def in_journey?
    entry_station != nil ? true : false
  end

  def add_journey
    @journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
