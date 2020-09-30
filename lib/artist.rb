class Artist
  attr_accessor :name, :id, :stage_id

  @@artists = {}
  @@artist_id = 0 

  def initialize(name, stage_id, id)
    @name = name
    @stage_id = stage_id
    @id = id || @@artist_id += 1
  end

  def self.all
    @@artists.values
  end

  def save
    @@artists[self.id] = Artist.new(self.name, self.stage_id, self.id)
  end

  def delete
    @@artists.delete(self.id)
  end

  def self.clear
    @@artists = {}
    @@artist_id = 0
  end

  def self.find(id)
    @@artists[id]
  end

  def == (param)
    self.name() == param.name()
  end

  def stage
    Stage.find(self.stage_id)
  end

  def self.find_by_stage(id)
    artists = []
    @@artists.values.each do |artist|
      if artist.stage_id == id
        artists.push(artist)
      end
    end
    artists
  end
end
