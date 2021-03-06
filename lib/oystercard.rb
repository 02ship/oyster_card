require_relative 'station'
require_relative 'journey'
class OysterCard
  attr_reader :balance, :journeys, :current_journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "card limit: #{CARD_LIMIT} reached" if amount + balance > CARD_LIMIT

    @balance += amount
    "topped up #{amount}"
  end

  def touch_in(station, journey = Journey.new(station))
    raise "minimum limit: #{MINIMUM_FARE} required" if balance < MINIMUM_FARE
      @current_journey = journey
  end

  def touch_out(station, journey = Journey.new(nil, station))
    @current_journey == nil ? @current_journey = journey : @current_journey.complete_journey(station)
    deduct(@current_journey.fare)
    add_journey
  end

  def in_journey?
    @current_journey != nil ? true : false
  end

  def add_journey
    @journeys << @current_journey
    @current_journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

#  def fare
#    return MINIMUM_FARE unless @current_journey == nil
#    @current_journey = Journey.new
#    PENALTY_FARE
#  end
end
