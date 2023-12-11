require 'csv'

class Reader
  INDEX_MAP = { account_number: 0, balance: 1, pin: 2, owner_name: 3 }

  def self.read_user_from_file(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      account_number = row['account_number'].to_i
      balance = row['balance'].to_f
      pin = row['pin'].to_i
      owner_name = row['owner_name']
      return User.new(owner_name, pin, balance, account_number)
    end
  end

  def self.user_details
    file_path = 'user.csv'
    read_user_from_file(file_path)
  end

  def self.update_balance(file_path, new_balance)
    user = read_user_from_file(file_path)
    CSV.open(file_path, 'w') do |csv|
      csv << %w[account_number balance pin owner_name] 
      csv << [user.account_number, new_balance , user.pin, user.owner_name]
    end
  end

  def self.balance_update(new_balance)
    file_path = 'user.csv'
    update_balance(file_path, new_balance)
  end

  def self.set_new_pin(file_path, new_pin)
    user = read_user_from_file(file_path)
    user.set_pin(new_pin)

    CSV.open(file_path, 'w') do |csv|
      csv << %w[account_number balance pin owner_name]
      csv << [user.account_number, user.balance, user.pin, user.owner_name]
    end

    puts 'New pin has been updated'
  end

  def self.set_pin(new_pin)
    file_path = 'user.csv'
    set_new_pin(file_path, new_pin)
  end
end
