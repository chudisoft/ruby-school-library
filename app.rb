require_relative 'main'

class App
  def initialize(main)
    @main = main
  end

  def run
    actions = [
      -> { @main.list_books }, -> { @main.list_people }, -> { @main.create_person }, -> { @main.create_book },
      -> { @main.create_rental }, -> { @main.list_rentals_for_person }
    ]
    loop do
      display_menu
      choice = gets.chomp.to_i
      case choice
      when 1..6
        actions[choice - 1].call
      when 7
        puts 'Exiting the app. Goodbye!'
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    run
  end

  def display_menu
    puts 'Options:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
    print 'Enter your choice: '
  end
end

app = App.new(Main.new)
app.run
