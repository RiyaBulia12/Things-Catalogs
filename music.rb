require_relative './item'


class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(genre, publish_date, archived, on_spotify: false)
    super(genre, publish_date, archived,)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    @on_spotify && super
  end

  def self.list_all_music_albums(albums)
    if albums.empty?
      return puts "\n-------------------------\n  No Music Albums Found \n-------------------------"
    end

    rows = []
    albums.each do |album|
      rows << [album.genre, album.publish_date, album.on_spotify, album.archived]
    end

    table = Terminal::Table.new
    table.title = "List of Music Albums"
    table.headings =['Genre', 'Published On', 'Available on Spotify?', 'Album Archived?']
    table.rows = rows

    puts table
  end

  def self.add_music_album(albums)
    puts "Enter the following details to Add albums"

    print "Genre: "
    genre = gets.chomp
    print "Published Date: "
    publish_date = gets.chomp
    print "Album Archived? (Y/N): "
    archived = gets.chomp.upcase == 'Y'
    print "Album on Spotify? (Y/N): "
    on_spotify = gets.chomp.upcase == 'Y'
    new(genre, publish_date, archived, on_spotify: on_spotify)
  end
end
