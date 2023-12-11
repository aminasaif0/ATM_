class Admin
  def initialize
    @pin = 2345
    @account_count = 2
  end

  def pin
    @pin
  end

  def account_count
    @account_count
  end
  
  def account_add
    @account_count += 1
  end
end