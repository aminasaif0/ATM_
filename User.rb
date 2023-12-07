
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
  
    def self.read_from_file(file_path)
        lines = File.readlines(file_path).map(&:chomp)
        account_number = lines[0].to_i
        balance = lines[1].to_f
        pin = lines[2].to_i
        owner_name = lines[3]
        User.new(owner_name, pin, balance, account_number)
    end

    file_path = 'user_data.txt'
    user_instance = User.read_from_file(file_path)
    puts user_instance
end 
