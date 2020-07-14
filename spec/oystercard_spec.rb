require 'oystercard'
describe OysterCard do
  describe '#initialize' do
    it 'is initialized with a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up(amount)' do
    it 'top up card with amount' do
      expect(subject.top_up(50)).to eq("topped up 50")
    end

    it 'prevents top up if limit exceeded' do
      expect { subject.top_up(100)}.to raise_error("card limit: #{OysterCard::CARD_LIMIT} reached")
    end
  end

#  describe '#deduct(amount)' do
#    it 'deducts an amount from the card balance' do
#      subject.top_up(OysterCard::CARD_LIMIT)
#      expect(subject.deduct(20)).to eq("20 deducted")
#    end
#  end
  describe '#touch_in' do
    let(:station) {double("station")}
    it 'allows a card to register the start of a journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      expect(subject.touch_in(station)).to eq("Touch-in successful")
    end
    it 'prevents touch-in if balance is below minimum fare' do
      expect { subject.touch_in(station) }.to raise_error "minimum limit: #{OysterCard::MINIMUM_FARE} required"
    end
    it 'records the station of entry' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    let(:station) {double("station")}
    it 'allows a card to register the end of a journey' do
      expect(subject.touch_out(station)).to eq("Touch-out successful")
    end
    it 'deducts the minimum fare from the balance upon journey completion' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-OysterCard::MINIMUM_FARE)
    end
    it 'clears the entry station history' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to be_nil
    end

    it 'stores exit station' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      exit_station = Station.new
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station) 
    end
  end
  describe '#in_journey?' do
    let(:station) {double("station")}
    it 'marks a card as in-use' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end
    it 'marks a card as not in-use' do
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
  end
end

