require_relative '../classes/genre'
require 'json'

describe Genre do
  before(:each) do
    @genre_obj = Genre.new('Hiphop')
  end

  context 'When testing the Genre class constructor' do
    it 'should return Genre instance' do
      expect(@genre_obj).to be_an_instance_of(Genre)
    end

    it 'should return correct data with correct data types' do
      expect(@genre_obj.id).to be_an_instance_of(Integer)
      expect(@genre_obj.name).to eq 'Hiphop'
      expect(@genre_obj.items).to be_an_instance_of(Array)
    end

    it 'should return array of genres' do
      list = Genre.list_all_genres
      expect(list).to be_an_instance_of(Array)
    end

    it 'should be able to add an item' do
      @item = Item.new('Hiphop', '2022', true)
      @genre_obj.add_item(@item)
      expect(@genre_obj.items).to include(@item)
    end
  end
end
