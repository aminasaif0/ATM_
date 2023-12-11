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
        puts " What would you like to do?"
        command = gets.chomp.to_i
        if command == 1
            puts "Please insert an amount"
            amount = gets.chomp.to_i
            user1.withdraw(amount)
        end
        
    end
end