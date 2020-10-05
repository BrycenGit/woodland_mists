require('spec_helper')
require('rspec')
require('stage')
require('artist')


describe ('Artist') do

  before(:each) do
    @stage = Stage.new({:name => "mountain jam", :location =>"north west", :id => nil})
    @stage.save()
  end

  describe('initialize') do
    it('it tests a new artist object') do 
      new_artist = Artist.new({:name => 'the roots',:id => nil, :stage_id => @stage.id, :time => Time.new(2020, 2, 20, 5, 30)})
      expect(new_artist.time.strftime("at %I:%M %p")).to(eq("at 05:30 AM"))
    end
  end


end