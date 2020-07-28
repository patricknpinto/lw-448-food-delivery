require_relative '../views/view'
require_relative '../models/meal'

class MealsController
  def initialize(meals_repository)
    @meals_repository = meals_repository
    @view = View.new
  end

  def create
    # ask the user for name
    name = @view.ask_for('name')
    # ask the user for price
    price = @view.ask_for('price')
    # create a new instance of meal
    meal = Meal.new(name: name, price: price)
    # add to repo
    @meals_repository.create(meal)
  end

  def index
    # get meals from repo
    meals = @meals_repository.all
    # ask the view to display
    @view.display_meals(meals)
  end
end
