require_relative 'reader'

class User
  attr_reader :owner_name, :pin, :balance, :account_number

  def initialize(owner_name, pin, balance, account_number)
    @owner_name = owner_name
    @pin = pin
    @balance = balance
    @account_number = account_number
  end
  def pin; @pin end
  def balance; @balance end
  def account_number; @account_number end
  def owner_name; @owner_name end
    
  def set_pin(new_pin)
    @pin = new_pin
    Reader.set_new_pin(account_number, new_pin)
  end

  def set_balance(symbol, amount)
    eval("@balance #{symbol}= #{amount}")
    Reader.balance_update(@balance)
  end

  def verified?(entered_pin)
    pin == entered_pin
  end

  def get_balance
    puts "#{owner_name}, your balance is #{balance}"
    puts "Please recharge your account. Your balance is #{balance}" if balance <= 0
  end

  def withdraw(amount)
    puts "***WARNING*** You're trying to make a transaction for an amount which is not available to you." if amount > balance
    set_balance('-', amount)
    get_balance
  end

  def deposit(amount)
    puts "You are depositing a total of #{amount}"
    set_balance('+', amount)
    get_balance
  end

  def to_s
    "Account Number: #{account_number}, Balance: #{balance}, Owner Name: #{owner_name}"
  end
end
