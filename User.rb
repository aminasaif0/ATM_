class User
    def initialize(owner_name, pin, balance, account_number)
        @owner_name = owner_name
        @pin = pin
        @balance = balance
        @account_number = account_number
    end
    def owner_name
        @owner_name;
    end
    def pin; @pin end
    def balance; @balance end
    def account_number; @account_number end
    def set_balance(symbol, amount)
        eval("@balance #{symbol}= #{amount}")
    end

    def to_s
        "Account Number: #{@account_number}, Balance: #{@balance}, Owner Name: #{@owner_name}"
    end
end 
