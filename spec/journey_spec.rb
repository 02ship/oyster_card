require 'journey'

describe Journey do
  describe '#initialize' do
    let(:journey) { Journey.new("Waterloo") }
    it 'assigns first argument to entry_station' do
        expect(journey.entry_station).to eq "Waterloo"
    end
    it 'nil is assigned if no second argument provided' do
        expect(journey.exit_station).to be_nil
    end
  end
end