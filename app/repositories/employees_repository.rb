require 'csv'
require_relative '../models/employee'

class EmployeesRepository
  def initialize(filepath)
    @employees = []
    @next_id = 1
    @filepath = filepath

    load_csv
  end

  def create(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
  end

  def all
    @employees
  end

  def find(username)
    # @employees.each do |employee|
    #   if employee.username == username
    #     return employee
    #   end
    # end
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    # this is in case the csv is empty
    @next_id = 0
    CSV.foreach(@filepath, csv_options) do |row|
      row[:id] = row[:id].to_i

      employee = Employee.new(row)

      # add employee to @employees array
      @employees << employee
      @next_id = row[:id]
    end

    @next_id += 1
  end
end