class ATM
    def initialize(balance, limit)
        @total_balance = balance
        @transaction_limit = limit
    end
    
    def self.get_balance
        puts "Total availble balance is #{balance}"
        puts "Please recharge your account. Your balance is #{balance}" if balance <= 0
    end

    def total_balance
        @total_balance
    end
    def transaction_limit
        @transaction_limit
    end

    def self.set_balance(symbol, amount)
        eval("@balance #{symbol}= #{amount}")
    end

    def self.withdraw(amount)
        puts "***WARNING*** you're trying to make transaction for an amount which is not available to you." if amount > balance
        set_balance(symbol "-", amount)
        get_balance
    end

    def self.deposit(amount)
        puts "You are depositing a total of #{amount}"
        set_balance(symbol "+", amount)
        get_balance
    end
end
