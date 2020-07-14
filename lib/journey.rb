class Journey
  attr_reader :entry_station, :exit_station
  def initialize(entry = nil, final = nil)
    @entry_station = entry
    @exit_station = final
  end

  def complete_journey(station)
    @exit_station = station
  end

end

#entry station
#exit station
