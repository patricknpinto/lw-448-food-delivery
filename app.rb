require_relative 'router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/meals_repository'
require_relative 'app/repositories/employees_repository'

meals_repository = MealsRepository.new('data/meals.csv')

meals_controller = MealsController.new(meals_repository)

employees_repository = EmployeesRepository.new('data/employees.csv')

p employees_repository

sessions_controller = SessionsController.new(employees_repository)

router = Router.new(meals_controller, sessions_controller)
router.run
