class App
  p 'App called'

  def user_choice(choice)
    option = main_menu[choice]
    case option 
    when 0
      app.list_all_music_albums
    when 1
      app.list_all_movies
    when 2
      app.list_all_genres
    when 3
      app.list_all_sources
    when 4
      app.add_music_album
    when 5
      app.add_movie
    when 6
      exit
    else
      puts 'Invalid option'
    end
  end

end
