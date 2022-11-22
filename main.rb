require_relative './app'

def main
  puts '---------------------------------------'
  puts '  Welcome to Catalog of My things App'
  puts '---------------------------------------'
  puts 'Select from the Menu'

  app = App.new()
  loop do
    menu
    choice = gets.to_i
    return if choice == 6
    app.user_choice(choice)
  end
end

def menu
  puts [
    '0. List all music albums',
    '1. List all movies',
    '2. List all genres',
    '3. List all sources',
    '4. Add a music album',
    '5. Add a movie',
    '6. Exit'
  ]
end

main
