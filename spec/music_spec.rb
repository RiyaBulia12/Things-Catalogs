require_relative '../classes/music'

describe MusicAlbum do
  before(:each) do
    @musicObj = MusicAlbum.new('Thriller', '2022', true, on_spotify: true)
  end

  context "When testing the MusicAlbum class constructor" do
    it 'should return MusicAlbum instance' do
      expect(@musicObj).to be_an_instance_of(MusicAlbum)
    end

    it 'should have Item as a superclass' do
      expect(@musicObj.class.superclass).to eq Item
    end

    it 'should return correct data with correct data types' do
      expect(@musicObj.id).to be_an_instance_of(Integer)
      expect(@musicObj.genre).to eq 'Thriller'
      expect(@musicObj.publish_date).to eq '2022'
      expect(@musicObj.archived).to eq true
      expect(@musicObj.on_spotify).to eq true
    end

    it 'should return nil when albums is []' do
      musicAlbum = MusicAlbum.list_all_music_albums([])
      expect(musicAlbum).to eq nil
    end
  end

end
