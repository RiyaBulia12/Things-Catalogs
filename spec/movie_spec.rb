require_relative '../classes/movie'

describe Movies do
  before(:each) do
    @movie_obj = Movies.new('2022', true, 'Thriller', on_spotify: true)
  end

  context 'When testing the Movies class constructor' do
    it 'should return Movies instance' do
      expect(@movie_obj).to be_an_instance_of(Movies)
    end

    it 'should have Item as a superclass' do
      expect(@movie_obj.class.superclass).to eq Item
    end

    it 'should return correct data with correct data types' do
      expect(@movie_obj.id).to be_an_instance_of(Integer)
      expect(@movie_obj.genre).to eq 'Thriller'
      expect(@movie_obj.publish_date).to eq '2022'
      expect(@movie_obj.archived).to eq true
      expect(@movie_obj.on_spotify).to eq true
    end

    it 'should return nil when albums is []' do
      expect(Movies.list_all_movies([])).to eq nil
    end
  end
end
