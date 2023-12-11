require_relative 'user'

class Reader
  INDEX_MAP = {:acc => 0, :balance => 1, :pin => 2, :owner_name => 3}
    def self.read_user_from_file(file_path)
        lines = File.readlines(file_path).map(&:chomp)
        account_number = lines[INDEX_MAP[:acc]].to_i
        balance = lines[INDEX_MAP[:balance]].to_f
        pin = lines[INDEX_MAP[:pin]].to_i
        owner_name = lines[INDEX_MAP[:owner_name]]
        userDataArray = [account_number, balance, pin, owner_name]
    end

    def self.user_details
        file_path = 'user_data.txt'
        read_user_from_file(file_path)
    end

    def self.update_balance(file_path, new_balance)
      user_data = read_user_from_file(file_path)
      user_data[INDEX_MAP[:balance]] = new_balance.to_f
  
      File.open(file_path, 'w') do |file|
        file.puts(user_data.join("\n"))
      end
    end    

    def self.balance_update(new_balance)
      file_path = 'user_data.txt'
      update_balance(file_path,new_balance)
    end

    def self.set_new_pin(file_path, new_pin)
      user_data = read_user_from_file(file_path)
      user_data[INDEX_MAP[:pin]] = new_pin.to_i
  
      File.open(file_path, 'w') do |file|
        file.puts(user_data.join("\n"))
      end
      puts "New pin has been updated"
    end

    def self.set_pin(new_pin)
      file_path = 'user_data.txt'
      set_new_pin(file_path, new_pin)
    end
end