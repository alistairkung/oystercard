require 'Oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:topup).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }
  describe "#balance" do
    it "should return the balance of the card" do
      expect(subject.balance).to eq(0)
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
    it "should deduct an amonunt from the balance" do
      subject.topup(100)
      expect{ subject.deduct 10 }.to change{ subject.balance }.by -10
    end
  end

end
