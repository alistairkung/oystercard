class Oystercard

  attr_reader :balance, :entry_station, :previous_journeys

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance           = balance
    @entry_station     = nil
    @previous_journeys = []
  end

  def topup(amount)
    raise "You have reached your maximum balance limit" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Please top up" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    record_journey(entry_station, station)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance-= amount
  end

  def record_journey(entry_station, exit_station)
    journey = { entry: entry_station, exit: exit_station }
    @previous_journeys.push journey
  end
end
