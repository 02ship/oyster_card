class Journey
  attr_reader :entry_station, :exit_station
  def initialize(entry = nil, final = nil)
    @entry_station = entry
    @exit_station = final
  end

  def complete_journey(station)
    @exit_station = station
    self
  end

  def complete?
    (@exit_station && @entry_station) != nil ? true : false
  end

  def fare
    return OysterCard::MINIMUM_FARE unless !complete?
    @current_journey = Journey.new
    OysterCard::PENALTY_FARE
  end
end
