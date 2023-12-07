require_relative 'reader'
require_relative 'ATM'

class Main
    puts "What is your pin?"
    pin = gets.chomp.to_i
    arr = Reader.user_details
    if(ATM.new.verified?(arr[2]))
        user1 = User.new(arr[3],arr[2],arr[1],arr[0])
        puts "Welcome to the Atm #{user1.owner_name}. Your available balance is #{user1.balance}"
        puts "What would you like to do today?"
    end
end