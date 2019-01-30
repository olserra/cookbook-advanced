class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the Cookbook!"
    puts "           --           "

    while @running
      display_recipes
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.create
    when 3 then @controller.destroy
    when 4 then @controller.import
    when 5 then @controller.mark
    when 6 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 6"
    end
  end

  def stop
    @running = false
  end

  def display_recipes
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Add a recipe"
    puts "3 - Delete a recipe"
    puts "4 - Import recipes from LetsCookFrench"
    puts "5 - Mark done recipes"
    puts "6 - Stop and exit the program"
  end
end
