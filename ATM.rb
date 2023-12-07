require_relative 'user'

class ATM < User
    def initialize
        total_balance = 100000
        transaction_limit = 20000
        @pin = pin
    end
    
    def verified?(pin)
        if self.pin == pin
            true
        else
            self.freeze
        end
    end
    
    def get_balance
        puts "#{owner_name} your balance is #{balance}"
        puts "Please recharge your account. Your balance is #{balance}" if balance <= 0
    end

    def withdraw(amount)
        puts "***WARNING*** you're trying to make transaction for an amount which is not available to you." if amount > balance
        set_balance(symbol "-", amount)
        get_balance
    end

    def deposit(amount)
        puts "You are depositing a total of #{amount}"
        set_balance(symbol "+", amount)
        get_balance
    end
end
