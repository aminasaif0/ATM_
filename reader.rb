require 'csv'

class Reader
  INDEX_MAP = { account_number: 0, balance: 1, pin: 2, owner_name: 3 }

  def self.read_user_from_file(file_path, account_number)
    CSV.foreach(file_path, headers: true) do |row|
      if row['account_number'].to_i == account_number
        balance = row['balance'].to_f
        pin = row['pin'].to_i
        owner_name = row['owner_name']

        return User.new(owner_name, pin, balance, account_number)
      end
    end
    nil  
  end
  def self.account_count
    file_path = 'account.csv'
    count = 0
    CSV.foreach(file_path, headers: true) do |row|
      count = row['account_count'].to_i
    end
    count
  end
  def self.update_account_count
    existing_data = account_count
    updated_count = existing_data + 1
    CSV.open('account.csv', 'w', write_headers: true, headers: ['account_count']) do |csv|
      csv << [updated_count]    
    end

    updated_count
  end
  def self.user_details(account_number)
    file_path = 'user.csv'
    read_user_from_file(file_path,account_number)
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

  def self.set_new_pin(account_number, new_pin)
    file_path = 'user.csv'
    rows = []
  
    CSV.foreach(file_path, headers: true) do |row|
      if row['account_number'].to_i == account_number
        row['pin'] = new_pin
      end
      rows << row
    end
  
    CSV.open(file_path, 'w') do |csv|
      csv << %w[account_number balance pin owner_name]
      rows.each { |r| csv << [r['account_number'], r['balance'], r['pin'], r['owner_name']] }
    end
  
    puts 'New pin has been updated'
  end
  
  def self.add_new_user(account_number, balance, pin, name)
    file_path = 'user.csv'
    
    existing_data = CSV.read(file_path, headers: true)
    if existing_data.any? { |row| row['account_number'].to_i == account_number }
      puts "User with account number #{account_number} already exists."
      return
    end

    new_row = [account_number, balance, pin, name]
    existing_data << new_row

    CSV.open(file_path, 'w') do |csv|
      csv << %w[account_number balance pin owner_name]
      existing_data.each { |row| csv << row }
    end
      puts "User with account number #{account_number} has been added."
  end
end