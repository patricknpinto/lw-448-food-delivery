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

  def wrong_credentials
    puts "Wrong credentials. Try again!"
  end

  def signed_in
    puts "Signed in successfully!"
  end
end
