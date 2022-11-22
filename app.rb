class App
  attr_accessor :movies, :albums, :genres, :sources
  def initialize
    @movies = []
    @albums = []
    @genres = []
    @sources = []
  end

  def user_choice(choice)
    option = main_menu[choice]
    case option
    when 0
      MusicAlbum.list_all_music_albums(@albums)
    when 1
      Movies.list_all_movies(@movies)
    when 2
      Genre.list_all_genres(@genres)
    when 3
      Source.list_all_sources(@sources)
    when 4
      MusicAlbum.add_music_album(@albums)
    when 5
      Movie.add_movie(@movies)
    else
      puts 'Invalid option'
    end
  end
end
