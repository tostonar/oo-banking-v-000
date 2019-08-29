require 'pry'
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
     if @sender.valid? && @receiver.valid?
      @sender.balance > @amount
     end
  end

  def execute_transaction
    if valid? && @status == "pending"
      #  binding.pry
        @sender.balance -= @amount
        @receiver.balance += @amount
        @status = "complete"
    else
       @status = "rejected"
       "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete" 
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    end
  end
end
