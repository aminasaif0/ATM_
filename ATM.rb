class ATM
    def initialize(balance)
        @total_balance = balance
        @transaction_limit = 20000
    end
    
    def get_balance
        puts "Total availble balance is #{total_balance}"
    end

    def total_balance
        @total_balance
    end
    def transaction_limit
        @transaction_limit
    end

    def set_balance(symbol, amount)
        eval("@total_balance #{symbol}= #{amount}")
    end

    def withdraw(amount)
        puts "***WARNING*** you're trying to make transaction for an amount which is not available to you." if amount > total_balance
        set_balance("-", amount)
    end

    def deposit(amount)
        puts "You are depositing a total of #{amount}"
        set_balance("+", amount)
        get_balance
    end
end
