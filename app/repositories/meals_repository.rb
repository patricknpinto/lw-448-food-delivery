require 'csv'

class MealsRepository
  def initialize(filepath)
    @meals = []
    @next_id = 1
    @filepath = filepath

    load_csv
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def all
    @meals
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    # this is in case the csv is empty
    @next_id = 0
    CSV.foreach(@filepath, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i

      # id = row[:id].to_i
      # price = row[:price].to_i

      # create a new instance of meal
      meal = Meal.new(row)
      # add meal to @meals array
      @meals << meal
      @next_id = row[:id]
    end

    @next_id += 1
  end

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
