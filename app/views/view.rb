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

  def display_customers(customers)
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name}"
    end
  end

  def display_employees(employees)
    employees.each do |employee|
      puts "#{employee.id}. #{employee.username}"
    end
  end

  def display_orders(orders)
    orders.each do |order|
      puts "#{order.id}. #{order.meal.name} - #{order.customer.name} - #{order.employee.username}"
    end
  end

  def wrong_credentials
    puts "Wrong credentials. Try again!"
  end

  def signed_in
    puts "Signed in successfully!"
  end
end
