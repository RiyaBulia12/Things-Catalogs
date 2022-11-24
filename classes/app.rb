require_relative './music'
require_relative './genre'
require_relative './movie'
require_relative './source'
require 'terminal-table'
require 'json'

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
      @albums = MusicAlbum.retrieve_music_albums
      MusicAlbum.list_all_music_albums(@albums)
    when 1
      @movies = Movies.retrieve_movies
      Movies.list_all_movies(@movies)
    when 2
      retrieve_genre_list
    when 3
      retrieve_source_list
    when 4
      create_new_music_data
    when 5
      create_new_movies_data
    else
      'Invalid option'
    end
  end

  def retrieve_genre_list
    @genres = Genre.list_all_genres
    if @genres.empty?
      Genre.create_genre_choice
    else
      Genre.enter_genre_details(@genres)
    end
  end

  def create_new_music_data
    @albums = MusicAlbum.retrieve_music_albums
    genre_name = retrieve_genre_list

    @albums << MusicAlbum.add_music_album(genre_name)

    puts "\n-----------------------------\n  Album Added Succesfully \n-----------------------------"
    MusicAlbum.save_music_album(@albums) if @albums.empty? == false
  end

  def retrieve_source_list
    @sources = Source.list_all_sources
    if @sources.empty?
      Source.create_source_choice
    else
      Source.enter_source_details(@sources)
    end
  end

  def create_new_movies_data
    @movies = Movies.retrieve_movies
    source_name = retrieve_source_list
    @movies << Movies.add_movie(source_name)

    puts "\n-----------------------------\n  Movies Added Succesfully \n-----------------------------"
    Movies.save_movies(@movies) if @movies.empty? == false
  end
end
