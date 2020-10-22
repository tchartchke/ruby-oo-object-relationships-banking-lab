class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    self.status = 'pending'
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance > amount
  end

  def execute_transaction
    if valid? && self.status == 'pending'
      self.sender.deposit(-amount)
      self.receiver.deposit(amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.receiver.deposit(-amount)
      self.sender.deposit(amount)
      self.status = "reversed"
    else
      self.status = "rejected"
      "Reversal rejected"
    end
  end

end
