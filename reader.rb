require_relative 'user'
class Reader
  INDEX_MAP = { account_number: 0, balance: 1, pin: 2, owner_name: 3 }

  def self.read_user_from_file(file_path)
    lines = File.readlines(file_path).map(&:chomp)
    user_data_array = []

    INDEX_MAP.each do |key, index|
      value = lines[index]
      
      converted_value = if key == :account_number || key == :pin
                          value.to_i
                        elsif key == :balance
                          value.to_f
                        else
                          value
                        end

      user_data_array << converted_value
    end

    user_data_array
  end

  def self.user_details
    file_path = 'user_data.txt'
    read_user_from_file(file_path)
  end
end
