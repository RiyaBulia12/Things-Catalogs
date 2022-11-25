require_relative '../classes/movie'

describe Movies do
  before(:each) do
    @music_obj = Movies.new('2022', true, 'Online', silent: true)
  end

  context 'When testing the Movies class constructor' do
    it 'should return Movies instance' do
      expect(@music_obj).to be_an_instance_of(Movies)
    end

    it 'should have Item as a superclass' do
      expect(@music_obj.class.superclass).to eq Item
    end

    it 'should return correct data with correct data types' do
      expect(@music_obj.id).to be_an_instance_of(Integer)
      expect(@music_obj.source).to eq 'Online'
      expect(@music_obj.publish_date).to eq '2022'
      expect(@music_obj.archived).to eq true
      expect(@music_obj.silent).to eq true
    end

    it 'should return nil when albums is []' do
      expect(Movies.list_all_movies([])).to eq nil
    end
  end
end
