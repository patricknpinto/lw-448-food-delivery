class Router
  def initialize(meals_controller, sessions_controller)
    @meals_controller = meals_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    while @running
      employee = @sessions_controller.sign_in

      if employee.manager?
        print_manager_menu
        choice = gets.chomp.to_i
        print `clear`
        manager_route_action(choice)
      else
        print_delivery_guy_menu
        choice = gets.chomp.to_i
        print `clear`
        delivery_guy_route_action(choice)
      end
    end
  end

  private

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "8. Exit"
    print "> "
  end

  def print_delivery_guy_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List my orders"
    puts "2. Mark order as delivered"
    puts "8. Exit"
    print "> "
  end

  def manager_route_action(choice)
    case choice
    when 1 then @meals_controller.create
    when 2 then @meals_controller.index
    # when 3 then ?
    # when 4 then ?
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def delivery_guy_route_action(choice)
    case choice
    when 1 then puts "TODO: listing orders..."
    when 2 then puts "TODO: Marking order as delivered..."
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def stop!
    @running = false
  end
end
