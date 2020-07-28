require_relative 'router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/meals_repository'

meals_repository = MealsRepository.new('data/meals.csv')

p meals_repository

meals_controller = MealsController.new(meals_repository)

router = Router.new(meals_controller)
router.run
