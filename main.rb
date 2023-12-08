require_relative 'reader'
require_relative 'ATM'
require_relative 'User'
class Main

    INDEX_MAP = {:acc => 0, :balance => 1, :pin => 2, :owner_name => 3}
    puts "What is your pin?"
    pin = gets.chomp.to_i
    arr = Reader.user_details
    user1 = User.new(arr[INDEX_MAP[:owner_name]],arr[INDEX_MAP[:pin]],arr[INDEX_MAP[:balance]],arr[INDEX_MAP[:acc]])
    puts "this is line 11"
    atm = ATM.new
    if(atm.verified?(arr[INDEX_MAP[:pin]]))
        puts "Welcome to the Atm #{user1.owner_name}. Your available balance is #{user1.balance}"
        puts " Select an option available in the menu."
        puts " Press 1 to Withdraw from your account."
        puts " Press 2 to deposit in your account."
        puts " Press 3 to check account details."
        command = gets.chomp.to_i
        if command == 1
            puts "Please insert an amount you want to withdraw."
            amount = gets.chomp.to_i
            user1.withdraw(amount)
        elsif command == 2
            puts "Please insert an ammount you want to deposit."
            amount = gets.chomp.to_i
            user1.deposit(ammount)
        elsif command == 3
            user1.get_balance
        else
            puts "Please choose an valid option"
        end
        
    end
end