require 'csv'

class Reader
  ACCOUNT_FILE_PATH = 'account.csv'
  USER_FILE_PATH = 'user.csv'

  def self.read_all_users_from_file
    CSV.read(USER_FILE_PATH, headers: true).map(&:to_h)
  end

  def self.account_count
    count = 0
    CSV.foreach(ACCOUNT_FILE_PATH, headers: true) do |row|
      count = row['account_count'].to_i
    end
    count
  end

  def self.update_account_count
    existing_data = account_count
    updated_count = existing_data + 1
    CSV.open(ACCOUNT_FILE_PATH, 'w', write_headers: true, headers: ['account_count']) do |csv|
      csv << [updated_count]
    end
    updated_count
  end

  def self.update_balance(account_number, new_balance)
    user_data = read_all_users_from_file.find { |row| row['account_number'].to_i == account_number }
    CSV.open(USER_FILE_PATH, 'w') do |csv|
      csv << user_data.keys
      csv << user_data.values.map { |value| value == user_data['balance'] ? new_balance : value }
    end
  end

  def self.set_new_pin(account_number, new_pin)
    rows = []
    CSV.foreach(USER_FILE_PATH, headers: true) do |row|
      if row['account_number'].to_i == account_number
        row['pin'] = new_pin
      end
      rows << row
    end

    CSV.open(USER_FILE_PATH, 'w') do |csv|
      csv << rows.first.keys
      rows.each { |r| csv << r.values }
    end

    puts 'New pin has been updated'
  end

  def self.add_new_user(account_number, balance, pin, name)
    existing_data = CSV.read(USER_FILE_PATH, headers: true)
    if existing_data.any? { |row| row['account_number'].to_i == account_number }
      puts "User with account number #{account_number} already exists."
      return
    end

    new_row = { 'account_number' => account_number, 'balance' => balance, 'pin' => pin, 'owner_name' => name }
    existing_data << new_row

    CSV.open(USER_FILE_PATH, 'w') do |csv|
      csv << new_row.keys
      existing_data.each { |row| csv << row.values }
    end

    puts "User with account number #{account_number} has been added."
  end
end