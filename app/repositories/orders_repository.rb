require 'csv'

class OrdersRepository
  def initialize(filepath, meals_repository, customers_repository, employees_repository)
    @orders = []
    @next_id = 1
    @filepath = filepath
    @meals_repository = meals_repository
    @customers_repository = customers_repository
    @employees_repository = employees_repository

    load_csv
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def all
    @orders
  end

  def find(id)
    @orders.find { |order| order.id == id.to_i }
  end

  def undelivered(employee_id)
    @orders.select { |order| order.undelivered? && order.employee.id == employee_id }
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    # this is in case the csv is empty
    @next_id = 0
    CSV.foreach(@filepath, csv_options) do |row|
      # convert the data type
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'

      # initialize the order
      order = Order.new(row)

      # ...
      # Get the instances with the id in the csv
      meal = @meals_repository.find(row[:meal_id])
      customer = @customers_repository.find(row[:customer_id])
      employee = @employees_repository.find(row[:employee_id])

      # set the correct instances in order
      order.meal = meal
      order.customer = customer
      order.employee = employee

      # # create a new instance of order
      # # add order to @orders array
      @orders << order
      @next_id = row[:id]
    end

    @next_id += 1
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered]
      end
    end
  end
end
