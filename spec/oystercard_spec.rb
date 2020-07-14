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

  describe '#touch_in' do
    let(:station) {double("station")}
    it 'allows a card to register the start of a journey' do
      subject.top_up(OysterCard::CARD_LIMIT)
      expect(subject.touch_in(station)).to be_instance_of(Journey)
    end
    it 'prevents touch-in if balance is below minimum fare' do
      expect { subject.touch_in(station) }.to raise_error "minimum limit: #{OysterCard::MINIMUM_FARE} required"
    end
  end

  describe '#touch_out' do
    let(:station) {double("station")}
    it 'allows a card to register the end of a journey' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.current_journey).to eq(nil)
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
      expect(subject.current_journey).to be_nil
    end
    it 'overwrites exit station' do
      subject.top_up(OysterCard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys[0].exit_station).to eq(station)
    end
    it 'deducts the penalty fare if entry station is nil' do
      subject.top_up(OysterCard::PENALTY_FARE)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-OysterCard::PENALTY_FARE)
    end
  
  end

  describe '#in_journey?' do
    let(:station) {double("station")}   
    it 'returns true when card touched in' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end
    it 'returns false once card touched out' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
  end
  describe '#journeys' do
    it 'journey list empty by default' do
      expect(subject.journeys).to be_empty
    end
    let(:station) {double("station")}
    
    it 'a)returns entry and exit stations b)touching in and out creates one journey ' do
      subject.top_up(OysterCard::CARD_LIMIT)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys[0].entry_station).to eq(station)
      expect(subject.journeys[0].exit_station).to eq(station)
      expect(subject.journeys.count).to eq 1
    end
    
  end
end
