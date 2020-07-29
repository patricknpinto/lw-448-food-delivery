class Employee
  attr_reader :id, :username, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role] # 'manager' / 'delivery_guy'
  end

  def valid_password?(user_password)
    user_password == @password
  end

  def manager?
    @role == 'manager'
  end
end