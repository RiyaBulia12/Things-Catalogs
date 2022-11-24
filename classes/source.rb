class Source
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name, id: rand(1...1000))
    super()
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item&.source = self
  end

  def self.list_all_sources
    sources = parse_data
    return [] if sources.nil? || sources.empty?

    row = []
    source_obj = []
    sources.each do |source|
      source_obj << new(source['name'])
      row << [sources.find_index(source), source['id'], source['name']]
    end
    create_table(row)
    source_obj
  end

  def self.parse_data
    JSON.parse(File.read('json/sources.json')) if File.exist?('json/sources.json')
  end

  def self.create_table(row)
    table = Terminal::Table.new
    table.title = 'List of sources'
    table.headings = %w[Index Id Name]
    table.rows = row

    puts table
  end

  def self.create_source_choice
    puts "\n-------------------------\n  No Sources Found \n-------------------------"
    print "Press \nY: To create new source\nN: To Exit "
    is_source_create_choice = gets.chomp.upcase == 'Y'
    return unless is_source_create_choice

    puts "\n-------------------------\n  Create Source \n-------------------------"
    create_new_source
  end

  def self.enter_source_details(source_list)
    print "1. Select Source \n2. Create New Source: "
    source_choice = gets.to_i

    source = ''
    case source_choice
    when 1
      print 'Select index from source list: '
      source_choice = gets.to_i
      source = source_list[source_choice]&.name
    when 2
      source = create_new_source
    else 'Invalid Option'
    end
    source
  end

  def self.create_new_source
    sources = []
    print 'Enter source Name: '
    source_name = gets.chomp
    sources << new(source_name)
    save_source(sources)
    source_name
  end

  def self.save_source(sources)
    sources_data = parse_data

    sources.each do |source|
      sources_data << {
        id: source.id,
        name: source.name
      }
    end

    File.write('json/sources.json', JSON.pretty_generate(sources_data))

    puts "\n-----------------------------\n  Source Added Succesfully \n-----------------------------"
  end
end
