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
end