class ATM
    attr_accessor :account_number, :balance, :owner_name
  
    def initialize(account_number, balance, owner_name)
      @account_number = account_number
      @balance = balance
      @owner_name = owner_name
    end

    def to_s
      "Account Number: #{@account_number}, Balance: #{@balance}, Owner Name: #{@owner_name}"
    end

    def self.read_from_file(file_path)
        lines = File.readlines(file_path).map(&:chomp)
        account_number = lines[0].to_i
        balance = lines[1].to_f
        owner_name = lines[2]
        ATM.new(account_number, balance, owner_name)
    end

    file_path = 'atm_data.txt'
    atm_instance = ATM.read_from_file(file_path)
    puts atm_instance
end
  