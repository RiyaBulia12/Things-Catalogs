require_relative './item'

class Movies < Item
  attr_accessor :silent

  def initialize(*args, source, silent: false)
    super(*args)
    @silent = silent
    @source = source
  end

  def can_be_archived?
    @silent && super
  end

  def self.list_all_movies(movies)
    return puts "\n------------------------\n  No movies Found \n-------------------------" if movies.empty?

    rows = []
    movies.each do |movie|
      rows << [movie.id, movie.publish_date, movie.archived, movie.source, movie.silent]
    end

    table = Terminal::Table.new
    table.title = 'List of Movies'
    table.headings = ['Id', 'Published On', 'movie Archived?', 'Source', 'Silent?']
    table.rows = rows
    puts table
  end

  def self.add_movie(source)
    puts 'Enter the following details to Add movies'
    print 'Published Date: '
    publish_date = gets.chomp
    print 'Album Archived? (Y/N): '
    archived = gets.chomp.upcase == 'Y'
    print 'Is it a silent movie? (Y/N) : '
    silent = gets.chomp.upcase == 'Y'
    new(publish_date, archived, source, silent: silent)
  end

  def self.save_movies(movies)
    movie_data = []
    movies.each do |movie|
      movie_data << {
        id: movie.id,
        source: movie.source,
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
      movies << new(movie['publish_date'], movie['archived'], movie['source'], silent: movie['silent'])
    end
    movies
  end
end
