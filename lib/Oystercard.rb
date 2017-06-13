class Oystercard

attr_reader :balance, :status

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0, status = :not_in_use)
    @balance = balance
    @status = status
  end

  def topup(amount)
    fail "You have reached your maximum balance limit" if @balance+amount > MAX_LIMIT
    @balance+= amount
  end

  def in_journey?
    @status == :in_use
  end

  def touch_in
    raise "Please top up" if @balance < MIN_FARE
    @status = :in_use
  end

  def touch_out
    deduct(MIN_FARE)
    @status = :not_in_use
  end

private

  def deduct(amount)
    @balance-= amount
  end


end
