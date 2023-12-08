require_relative 'reader'
require_relative 'ATM'
require_relative 'User'
class Main

    INDEX_MAP = {:acc => 0, :balance => 1, :pin => 2, :owner_name => 3}
    puts "What is your pin?"
    pin = gets.chomp.to_i
    arr = Reader.user_details
    user1 = User.new(arr[INDEX_MAP[:owner_name]],arr[INDEX_MAP[:pin]],arr[INDEX_MAP[:balance]],arr[INDEX_MAP[:acc]])
    atm = ATM.new(121232)
    if(user1.verified?(pin))
        puts "Welcome to the Atm #{user1.owner_name}. Your available balance is #{user1.balance}"
        puts " Select an option available in the menu."
        puts " Press 1 to Withdraw from your account."
        puts " Press 2 to deposit in your account."
        puts " Press 3 to check account details."
        command = gets.chomp.to_i
        if command == 1
            puts "Please insert an amount you want to withdraw."
            amount = gets.chomp.to_i
            if(atm.total_balance > amount && atm.transaction_limit > amount)
                user1.withdraw(amount)
                atm.withdraw(amount)
            else
                puts "Invalid Funds in the ATM."
            end
        elsif command == 2
            puts "Please insert an ammount you want to deposit."
            amount = gets.chomp.to_i
            user1.deposit(amount)
        elsif command == 3
            user1.get_balance
        else
            puts "You have made an invalid request. Please try again."
        end
    else
        p "I will freeze"
        self.freeze
    end
end