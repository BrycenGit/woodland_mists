require('spec_helper')
require('rspec')
require('stage')
require('artist')

describe('Stage') do

  describe('.all') do
    it('returns an array containing all stages') do
      expect(Stage.all).to(eq([]))
    end
  end

  describe('#save') do
    it('returns an array containing all stages') do
      stage1 = Stage.new({:name => 'forest', :location => 'west', :id => nil})
      stage1.save
      expect(Stage.all).to(eq([stage1]))
    end
  end

  describe('#delete') do
    it('returns an array containing all stages') do
      stage1 = Stage.new({:name => 'forest', :location => 'west', :id => nil})
      stage1.save
      stage1.delete
      expect(Stage.all).to(eq([]))
    end
  end

  describe('.find') do
    it('searches for stage by id') do
      stage1 = Stage.new({:name => 'forest', :location => 'west', :id => nil})
      stage1.save
      expect(Stage.find(stage1.id)).to(eq(stage1))
    end
  end
end