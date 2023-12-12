require_relative 'reader'
require_relative 'atm'
require_relative 'user'
require_relative 'admin'

class Main
  def self.main_menu
    atm = ATM.new(121232)
    
    puts "Choose whom you want to login as;"
    puts "Press 1 if you want to login as Admin"
    puts "Press 2 if you want to login as User"
    
    user_choice = gets.chomp.to_i
    
    if user_choice == 1
      admin_login
    elsif user_choice == 2
        user1 = get_user
        user_login(user1, atm)
    else
      puts "Invalid choice option selected"
    end
  end

  def self.get_user
    puts "Enter User Account Number"
    acc = gets.chomp.to_i
    user = User.find_and_initialize(acc)
    puts user.owner_name
    user
  end

  def self.admin_login
    puts "What is your pin?"
    admin_pin = gets.chomp.to_i
    admin = Admin.new

    if admin_pin == admin.pin
      admin_menu(admin)
    else
      puts "Invalid Admin PIN"
    end
  end

  def self.admin_menu(admin)
    puts "Welcome to the System."
    puts "Select the operation you want to perform."
    puts "Select 1 if you want to check ATM Balance"
    puts "Select 2 if you want to add to ATM Balance"
    puts "Select 3 if you want to reset Pin for user"
    puts "Select 4 if you want to add a new user account"

    menu_option = gets.chomp.to_i
    
    case menu_option
    when 1
      puts admin.get_atm_balance
    when 2
      puts "How much do you want to deposit into the ATM?"
      amount = gets.chomp.to_i
      admin.deposit_to_atm(amount)
    when 3
      user1 = get_user
      puts "Insert New Pin"
      new_pin = gets.chomp.to_i
      user1.set_pin(new_pin)
    when 4
        puts "Please Enter a valid Name"
        name = gets.chomp.to_s
        puts "Please Deposit initial amount."
        deposit = gets.chomp.to_f
        puts "Please select a PIN"
        pin = gets.chomp.to_i
        ac = Reader.account_count + 1
        Reader.add_new_user(ac, deposit, pin, name)
        Reader.update_account_count
    else
      puts "Choose a valid menu option"
    end
  end

  def self.user_login(user, atm)
    puts "What is your pin?"
    pin = gets.chomp.to_i
    puts "I am pin"
    puts user.pin
    if user.verified?(pin)
      user_menu(user, atm)
    else
      puts "Invalid User PIN"
    end
  end

  def self.user_menu(user, atm)
    puts "Welcome to the ATM #{user.owner_name}. Your available balance is #{user.balance}"
    puts "Select an option available in the menu."
    puts "Press 1 to Withdraw from your account."
    puts "Press 2 to deposit in your account."
    puts "Press 3 to check account details."

    command = gets.chomp.to_i
    
    case command
    when 1
      withdraw(user, atm)
    when 2
      deposit(user)
    when 3
      puts user.get_balance
    else
      puts "You have made an invalid request. Please try again."
    end
  end

  def self.withdraw(user, atm)
    puts "Please insert an amount you want to withdraw."
    amount = gets.chomp.to_i

    if atm.total_balance > amount && atm.transaction_limit > amount
      user.withdraw(amount)
      atm.withdraw(amount)
    else
      puts "Invalid Funds in the ATM."
    end
  end

  def self.deposit(user)
    puts "Please insert an amount you want to deposit."
    amount = gets.chomp.to_i
    user.deposit(amount)
  end

  main_menu
end
