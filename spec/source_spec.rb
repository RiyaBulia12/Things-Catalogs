require_relative '../classes/source'
require 'json'

describe Source do
  before(:each) do
    @source_obj = Source.new('ott')
  end

  context 'When testing the Source class constructor' do
    it 'should return Source instance' do
      expect(@source_obj).to be_an_instance_of(Source)
    end

    it 'should return correct data with correct data types' do
      expect(@source_obj.id).to be_an_instance_of(Integer)
      expect(@source_obj.name).to eq 'ott'
      expect(@source_obj.items).to be_an_instance_of(Array)
    end

    it 'should be able to add an item' do
      @item = Item.new(true, '2022')
      @source_obj.add_item(@item)
      expect(@source_obj.items).to include(@item)
    end
  end
end
