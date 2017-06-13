class Oystercard

attr_reader :balance, :status, :entry_station

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0, status = :not_in_use)
    @balance = balance
    @status = status
    @entry_station = nil
  end

  def topup(amount)
    fail "You have reached your maximum balance limit" if @balance+amount > MAX_LIMIT
    @balance+= amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Please top up" if @balance < MIN_FARE
    @entry_station = station
    @status = :in_use
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
    @status = :not_in_use
  end



private

  def deduct(amount)
    @balance-= amount
  end


end
