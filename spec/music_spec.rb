require_relative '../classes/music'

describe MusicAlbum do
  before(:each) do
    @music_obj = MusicAlbum.new('2022', true, 'Thriller', on_spotify: true)
  end

  context 'When testing the MusicAlbum class constructor' do
    it 'should return MusicAlbum instance' do
      expect(@music_obj).to be_an_instance_of(MusicAlbum)
    end

    it 'should have Item as a superclass' do
      expect(@music_obj.class.superclass).to eq Item
    end

    it 'should return correct data with correct data types' do
      expect(@music_obj.id).to be_an_instance_of(Integer)
      expect(@music_obj.genre).to eq 'Thriller'
      expect(@music_obj.publish_date).to eq '2022'
      expect(@music_obj.archived).to eq true
      expect(@music_obj.on_spotify).to eq true
    end

    it 'should return nil when albums is []' do
      expect(MusicAlbum.list_all_music_albums([])).to eq nil
    end
  end
end
