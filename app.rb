require_relative 'router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/controllers/orders_controller'
require_relative 'app/repositories/meals_repository'
require_relative 'app/repositories/employees_repository'
require_relative 'app/repositories/customers_repository'
require_relative 'app/repositories/orders_repository'

meals_repository = MealsRepository.new('data/meals.csv')
employees_repository = EmployeesRepository.new('data/employees.csv')
customers_repository = CustomersRepository.new('data/customers.csv')
orders_repository = OrdersRepository.new('data/orders.csv', meals_repository, customers_repository, employees_repository)

meals_controller = MealsController.new(meals_repository)
sessions_controller = SessionsController.new(employees_repository)
orders_controller = OrdersController.new(meals_repository, employees_repository, customers_repository, orders_repository)

router = Router.new(meals_controller, sessions_controller, orders_controller)
router.run
