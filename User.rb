require_relative 'reader'

class User
    attr_reader :account_number, :balance, :pin, :owner_name

    def initialize(data)
      @account_number = data['account_number']
      @balance = data['balance'].to_f
      @pin = data['pin'].to_i
      @owner_name = data['owner_name']
    end
  
    def self.find_and_initialize(account_number)
      user_data = Reader.read_all_users_from_file.find { |row| row['account_number'].to_i == account_number }
      return nil unless user_data
  
      new(user_data)
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
