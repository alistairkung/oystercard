class Oystercard

attr_reader :balance, :status

  MAX_LIMIT = 100

  def initialize(balance = 0, status = :not_in_use)
    @balance = balance
    @status = status
  end

  def topup(amount)
    fail "You have reached your maximum balance limit" if @balance+amount > MAX_LIMIT == true
    @balance+= amount
  end

  def deduct(amount)
    @balance-= amount
  end

  def in_journey?
    @status == :in_use
  end

  def touch_in
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
  end

end
