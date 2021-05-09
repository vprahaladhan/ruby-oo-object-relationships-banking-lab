class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if (@status == 'pending') then
      if (@sender.status == 'closed' || @receiver.status == 'closed' || @sender.balance < @amount) then 
        @status = 'rejected'
        "Transaction rejected. Please check your account balance."
      else 
        @sender.balance -= @amount
        @receiver.balance += @amount
        @status = 'complete'
      end
    end
  end

  def reverse_transfer
    if (@status == 'complete')
      @status = 'reversed'
      @sender.balance += @amount
      @receiver.balance -= @amount
    end
  end
end
