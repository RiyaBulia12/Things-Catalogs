require_relative './music.rb'
require_relative './genre.rb'


class App
  attr_accessor :movies, :albums, :genres, :sources

  def initialize
    @movies = []
    @albums = []
    @genres = []
    @sources = []
  end

  def user_choice(choice)
    case choice
    when 0
      MusicAlbum.list_all_music_albums(@albums)
    when 1
      Movies.list_all_movies(@movies)
    when 2
      Genre.list_all_genres(@genres)
    when 3
      Source.list_all_sources(@sources)
    when 4
      album = MusicAlbum.add_music_album(@albums)
      @albums << album
      puts "\n-----------------------------\n  Album Added Succesfully \n-----------------------------"
    when 5
      Movie.add_movie(@movies)
    else
      puts 'Invalid option'
    end
  end
end
