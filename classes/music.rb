require_relative './item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(*args, genre, on_spotify: false)
    super(*args)
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    @on_spotify && super
  end

  def self.list_all_music_albums(albums)
    return puts "\n-------------------------\n  No Music Albums Found \n-------------------------" if albums.empty?

    rows = []
    albums.each do |album|
      rows << [album.id, album.publish_date, album.archived, album.genre, album.on_spotify]
    end

    table = Terminal::Table.new
    table.title = 'List of Music Albums'
    table.headings = ['Id', 'Published On', 'Album Archived?', 'Genre', 'Available on Spotify?']
    table.rows = rows

    puts table
  end

  def self.add_music_album(genre)
    puts 'Enter the following details to Add albums'
    print 'Published Date: '
    publish_date = gets.chomp
    print 'Album Archived? (Y/N): '
    archived = gets.chomp.upcase == 'Y'
    print 'Album on Spotify? (Y/N): '
    on_spotify = gets.chomp.upcase == 'Y'
    new(publish_date, archived, genre, on_spotify: on_spotify)
  end

  def self.save_music_album(albums)
    albums_data = []
    albums.each do |album|
      albums_data << {
        id: album.id,
        genre: album.genre,
        publish_date: album.publish_date,
        archived: album.archived,
        on_spotify: album.on_spotify
      }
    end
    File.write('json/albums.json', JSON.pretty_generate(albums_data))
  end

  def self.retrieve_music_albums
    return [] unless File.exist?('json/albums.json')

    albums_data = JSON.parse(File.read('json/albums.json'))
    albums = []
    albums_data.each do |album|
      albums << new(album['publish_date'], album['archived'], album['genre'], on_spotify: album['on_spotify'])
    end
    albums
  end
end
