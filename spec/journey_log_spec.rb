require 'journey_log'
describe JourneyLog do
  describe '#initialize(journey_class)' do
    let(:journey) { Journey.new("Waterloo") }
    it 'initializes with an instance of journey class' do
      log = JourneyLog.new(:journey)
      expect(log).not_to be_nil
    end
  end
end
