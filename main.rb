require_relative 'reader'
require_relative 'ATM'
require_relative 'User'
require_relative 'admin'
class Main
    INDEX_MAP = {:acc => 0, :balance => 1, :pin => 2, :owner_name => 3}
    atm = ATM.new(121232)
    arr = Reader.user_details
    user1 = User.new(arr[INDEX_MAP[:owner_name]],arr[INDEX_MAP[:pin]],arr[INDEX_MAP[:balance]],arr[INDEX_MAP[:acc]])
        
    puts "Choose whom you want to login as;"
    puts "Press 1 if you want to login as Admin"
    puts "Press 2 if you want to login as User"
    user_choice = gets.chomp.to_i
    if(user_choice == 1)
        puts "What is your pin?"
        admin_pin = gets.chomp.to_i
        admin = Admin.new
        if(admin_pin == admin.pin)
            puts "Welcome to the System."
            puts "Select the operation you want to perform."
            puts "Select 1 if you want to check ATM Balance"
            puts "Select 2 if you want to add to ATM Balance"
            puts "Select 3 if you want to reset Pin for user"
            menu_option = gets.chomp.to_i
            if(menu_option == 1)
                puts atm.get_balance
            elsif(menu_option == 2)
                puts "How much do you want to deposit into the ATM?"
                amount = gets.chomp.to_i
                atm.deposit(amount)
            elsif(menu_option == 3)
                puts "Insert new pin"
                new_pin = gets.chomp.to_i
                user1.set_pin(new_pin)
            else
                "Choose a valid menu option"
            end
        end
    elsif(user_choice == 2)
        puts "What is your pin?"
        pin = gets.chomp.to_i
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
    else
        puts "Invalid choice option selected"
    end
end