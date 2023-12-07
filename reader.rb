require_relative 'user'

class Reader
    
    def self.read_user_from_file(file_path)
        lines = File.readlines(file_path).map(&:chomp)
        account_number = lines[0].to_i
        balance = lines[1].to_f
        pin = lines[2].to_i
        owner_name = lines[3]
        userDataArray = [account_number, balance, pin, owner_name]
    end

    def self.user_details
        file_path = 'user_data.txt'
        read_user_from_file(file_path)
    end
end