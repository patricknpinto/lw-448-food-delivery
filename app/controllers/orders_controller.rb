require_relative '../views/view'
require_relative '../models/order'
require 'pry-byebug'

class OrdersController
  def initialize(meals_repository, employees_repository, customers_repository, orders_repository)
    @meals_repository = meals_repository
    @employees_repository = employees_repository
    @customers_repository = customers_repository
    @orders_repository = orders_repository
    @view = View.new
  end

  def create
    # ask the user for meal id
    meals = @meals_repository.all
    @view.display_meals(meals)
    meal_id = @view.ask_for(:id)

    # ask the user for customer id
    customers = @customers_repository.all
    @view.display_customers(customers)
    customer_id = @view.ask_for(:id)

    # ask the user for employee id
    employees = @employees_repository.all_delivery_guys
    @view.display_employees(employees)
    employee_id = @view.ask_for(:id)

    # Get the instance with the id entered by the user
    meal = @meals_repository.find(meal_id)
    customer = @customers_repository.find(customer_id)
    employee = @employees_repository.find(employee_id)

    # create new instance of order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # add order to repo
    @orders_repository.create(order)
  end

  def list_my_orders(employee_id)
    orders = @orders_repository.undelivered(employee_id)
    @view.display_orders(orders)
  end
end
