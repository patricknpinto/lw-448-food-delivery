require 'csv'
require_relative '../models/customer'

class CustomersRepository
  def initialize(filepath)
    @customers = []
    @next_id = 1
    @filepath = filepath

    load_csv
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id.to_i }
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    # this is in case the csv is empty
    @next_id = 0
    CSV.foreach(@filepath, csv_options) do |row|
      row[:id] = row[:id].to_i

      customer = Customer.new(row)

      # add customer to @customers array
      @customers << customer
      @next_id = row[:id]
    end

    @next_id += 1
  end
end
