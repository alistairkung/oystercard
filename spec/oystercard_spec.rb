require 'Oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:topup).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  describe "#balance" do
    it "should return the balance of the card" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#in_journey?" do
    it "should return false" do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe "#topup" do
    it "should add a specified amount to the balance" do
      expect{ subject.topup 10 }.to change{ subject.balance }.by 10
    end

    context "new balance would exceed the limit" do
      it "should raise an error" do
        subject.topup Oystercard::MAX_LIMIT
        expect{ subject.topup(1) }.to raise_error("You have reached your maximum balance limit")
      end
    end

  end

  describe "#deduct" do
    it "should deduct an amount from the balance" do
      subject.topup(Oystercard::MAX_LIMIT)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

  describe "#touch_in" do
    it "should change in_journey to true" do
      subject.topup(Oystercard::MIN_FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    context "Not enough money on card" do
      it "should raise an error" do
        expect { subject.touch_in }.to raise_error("Please top up")
      end
    end
  end

  describe "#touch_out" do
    it "should change in_journey to false" do
      subject.topup(Oystercard::MIN_FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
