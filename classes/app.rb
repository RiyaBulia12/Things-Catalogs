require_relative './music'
require_relative './genre'
require 'terminal-table'
require 'json'
require_relative './movies'

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
      Movies.list_all_movies(@movies)
    when 2
      Genre.list_all_genres
    when 3
      Source.list_all_sources(@sources)
    when 4
      create_new_music_data
    when 5
      Movies.add_movie(@movies)
    else
      'Invalid option'
    end
  end

  def create_new_music_data
    @albums = MusicAlbum.retrieve_music_albums
    album = MusicAlbum.add_music_album
    @albums << album
    puts "\n-----------------------------\n  Album Added Succesfully \n-----------------------------"
    MusicAlbum.save_music_album(@albums) if @albums.empty? == false
  end
end
