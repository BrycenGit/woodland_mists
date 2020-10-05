class Artist
  attr_accessor :name, :id, :stage_id, :time


  def initialize(attributes)
    @name = attributes.fetch(:name)
    @stage_id = attributes.fetch(:stage_id)
    @id = attributes.fetch(:id)
    @time =attributes.fetch(:time)
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      stage_id = artist.fetch("stage_id").to_i
      id = artist.fetch("id").to_i
      time = artist.fetch("time")
      artists.push(Artist.new({:name => name, :stage_id => stage_id, :id => id, :time => time}))
    end
    artists
  end

  def save
    result = DB.exec("INSERT INTO artists (name, stage_id, time) VALUES ('#{@name}', #{@stage_id}, '#{@time}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def delete
    DB.exec("DELETE FROM artists WHERE id = #{@id}")
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id=#{id};").first
    name = artist.fetch("name")
    stage_id = artist.fetch("id").to_i
    id = artist.fetch("id").to_i
    time = artist.fetch("time")
    Artist.new({:name => name, :stage_id => stage_id, :id => id, :time => time})
  end

  def ==(param)
    if param != nil
      (self.name() == param.name()) && (self.stage_id() == param.stage_id())
    else
      false
    end
  end
  
  def update(name, stage_id)
    @name = name
    @stage_id = stage_id
    DB.exec("UPDATE artists SET name = '#{@name}', stage_id = #{@stage_id}, time = #{time}, WHERE id = #{@id};")
  end

  def stage
    Stage.find(@stage_id)
  end

  def self.find_by_stage(id)
    artists = []
    returned_artists = DB.exec("SELECT * FROM artists WHERE stage_id = #{id};")
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      stage_id = artist.fetch("stage_id").to_i
      time = artist.fetch("time")
      artists << Artist.new({:name => name, :id => id, :stage_id => stage_id, :time => time})
    end
    artists 
  end
end

