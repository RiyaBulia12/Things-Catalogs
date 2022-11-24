require_relative './item'

class Movies < Item
  def initialize(*args, silent:false) 
    super(*args)
    @silent = silent
  end
  def can_be_archived?
    @silent && super
  end
  def self.list_all_movies(movies)
    return puts "\n------------------------\n  No movies Found \n-------------------------" if movies.empty?

    rows = []
    movies.each do |movie|
      rows << [movie.id, movie.genre, movie.publish_date, movie.silent, movie.archived]
  end
  table = Terminal::Table.new
  table.title = 'List of Movies'
  table.headings = ['Id', 'Genre', 'Published On', 'silent?', 'movie Archived?']
  table.rows = rows
  puts table
  end

  def self.add_movie
    puts 'Enter the following details to Add movies'
    genre = Genre.enter_genre_details
    print 'Published Date: '
    publish_date = gets.chomp
    print 'Album Archived? (Y/N): '
    archived = gets.chomp.upcase == 'Y'
    print 'Album on Spotify? (Y/N): '
    silent = gets.chomp.upcase == 'Y'
    new(genre, publish_date, archived, silent: silent)
  end
  def self.save_movies(  )
    movie_data = []
    movies.each do |movie|
      movie_data << {
        id: movie.id,
        genre: movie.genre,
        publish_date: movie.publish_date,
        archived: movie.archived,
        silent: movie.silent
      }
    end
    File.write('json/movies.json', JSON.pretty_generate(movie_data))
  end

  def self.retrieve_movies
    return [] unless File.exist?('json/movies.json')

    movie_data = JSON.parse(File.read('json/movies.json'))
    movies = []
    movie_data.each do |movie|
      movies << new(movie['genre'], movie['publish_date'], movie['archived'], silent: movie['silent'])
    end
    movies
  end
  
end