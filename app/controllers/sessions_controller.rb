require_relative '../views/view'

class SessionsController
  def initialize(employees_repository)
    @employees_repository = employees_repository
    @view = View.new
  end

  def sign_in
    # ask for username
    username = @view.ask_for(:username)
    # ask for password
    password = @view.ask_for(:password)
    # find the employee with the given username
    employee = @employees_repository.find(username)
    # validate the password
    if employee && employee.valid_password?(password)
      @view.signed_in
      return employee
    else
      # show wrong credentials message
      @view.wrong_credentials
      # try log in again
      sign_in # recursive call
    end
    # log in
  end
end