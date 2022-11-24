class Item
  attr_accessor :publish_date
  attr_reader :archived, :id

  def initialize(publish_date, archived, genre: 'Music', source: 'Online', author: 'Unknown', label: 'Unknown', id: rand(1...1000))
    @id = id
    @genre = genre
    @publish_date = publish_date
    @archived = archived
    @source = source
  end

  def can_be_archived?
    Date.parse(@publish_date).year - Date.today.year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def add_genre(genre)
    genre.add_item(self)
  end

  def add_author(author)
    author.add_item(self)
  end

  def add_label(label)
    label.add_item(self)
  end

  def add_source(source)
    source.add_item(self)
  end

  private :can_be_archived?
end
