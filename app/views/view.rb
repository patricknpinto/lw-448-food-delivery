class View
  def ask_for(keyword)
    puts "#{keyword}?"
    print '> '
    gets.chomp
  end

  def display_meals(meals)
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name} (#{meal.price}€)"
    end
  end
end
