require ATM
require User
require reader

class Admin
    def initialize
      @users = []
    end

    def check_atm_balance(atm_instance)
      puts "ATM Balance: #{atm_instance.balance}"
    end
  end
  
  admin = Admin.new

  atm_file_path = 'atm_data.txt'
  atm_instance = ATM.read_from_file(atm_file_path)
  puts "Initial ATM Data: #{atm_instance}"
  
  admin.check_atm_balance(atm_instance)
  
end