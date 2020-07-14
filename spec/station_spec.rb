require 'station'
describe Station do
  describe '#initialize' do
    subject { Station.new("Waterloo", 6) }
    it 'assigns a name to the station' do
      expect(subject.name).to eq("Waterloo")
    end
    it 'assigns a zone to the station' do
      expect(subject.zone).to eq(6)
    end
  end
end
