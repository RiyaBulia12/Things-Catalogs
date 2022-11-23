class Genre
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name, id: rand(1...1000))
    super()
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item&.genre = self
  end

  def self.list_all_genres
    genres = parse_data
    return create_genre_choice if genres.nil? || genres.empty?

    row = []
    genres.each do |genre|
      row << [genres.find_index(genre), genre['id'], genre['name']]
    end
    create_table(row)
    row
  end

  def self.parse_data
    JSON.parse(File.read('json/genres.json')) if File.exist?('json/genres.json')
  end

  def self.create_table(row)
    table = Terminal::Table.new
    table.title = 'List of Genres'
    table.headings = %w[Index Id Name]
    table.rows = row

    puts table
  end

  def self.create_genre_choice
    puts "\n-------------------------\n  No Genres Found \n-------------------------"
    print "Press \nY: To create new genre\nN: To Exit "
    is_genre_create_choice = gets.chomp.upcase == 'Y'
    return unless is_genre_create_choice

    puts "\n-------------------------\n  Create Genre \n-------------------------"
    create_new_genre
  end

  def self.enter_genre_details
    genre_list = list_all_genres
    print "1. Select Genre \n2. Create New Genre: "
    genre_choice = gets.to_i

    genre = ''
    case genre_choice
    when 1
      print 'Select index from genre list: '
      genre_choice = gets.to_i
      genre = genre_list[genre_choice][2]
    when 2
      genre = create_new_genre
    else 'Invalid Option'
    end
    genre
  end

  def self.create_new_genre
    genres = []
    print 'Enter Genre Name: '
    genre_name = gets.chomp
    genres << new(genre_name)
    save_genre(genres)
    genre_name
  end

  def self.save_genre(genres)
    genres_data = parse_data

    genres.each do |genre|
      genres_data << {
        id: genre.id,
        name: genre.name
      }
    end

    File.write('json/genres.json', JSON.pretty_generate(genres_data))

    puts "\n-----------------------------\n  Genre Added Succesfully \n-----------------------------"
  end
end
