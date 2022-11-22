require_relative './item'
require 'terminal-table'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(genre, publish_date, archived, id: rand(1...1000), on_spotify: false)
    super(genre, publish_date, archived, id:)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    @on_spotify && super
  end

  def self.list_all_music_albums(albums)
    return puts "\n-------------------------\n  No Music Albums Found \n-------------------------" if albums.empty?

    rows = []
    albums.each do |album|
      rows << [album.id, album.genre, album.publish_date, album.on_spotify, album.archived]
    end

    table = Terminal::Table.new
    table.title = 'List of Music Albums'
    table.headings = ['Id', 'Genre', 'Published On', 'Available on Spotify?', 'Album Archived?']
    table.rows = rows

    puts table
  end

  def self.add_music_album
    puts 'Enter the following details to Add albums'

    print 'Genre: '
    genre = gets.chomp
    print 'Published Date: '
    publish_date = gets.chomp
    print 'Album Archived? (Y/N): '
    archived = gets.chomp.upcase == 'Y'
    print 'Album on Spotify? (Y/N): '
    on_spotify = gets.chomp.upcase == 'Y'
    new(genre, publish_date, archived, on_spotify:)
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
      albums << new(album['genre'], album['publish_date'], album['archived'], on_spotify: album['on_spotify'])
    end
    albums
  end
end
