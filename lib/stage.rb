class Stage
  attr_accessor :name, :location, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @location = attributes.fetch(:location)
    @id = attributes.fetch(:id)
  end

  def self.all()
    returned_stages = DB.exec("SELECT * FROM stages;")
    stages = []
    returned_stages.each() do |stage|
      name = stage.fetch("name")
      id = stage.fetch("id").to_i
      location = stage.fetch("location")
      stages << (Stage.new({:name => name, :id => id, :location => location}))
    end
    stages
  end

  def save
    result = DB.exec("INSERT INTO stages (name, location) VALUES ('#{@name}', '#{@location}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def delete
    DB.exec("DELETE FROM stages WHERE id = #{@id};")
    DB.exec("DELETE FROM artists WHERE stage_id = #{@id};")
  end

  def == (param)
    self.name() == param.name()
  end

  def self.clear
    DB.exec("DELETE FROM stagess *;")
  end

  def self.find(id)
   stage = DB.exec("SELECT * FROM stages WHERE id = #{id};").first
   name = stage.fetch("name")
   id = stage.fetch("id").to_i
   location = stage.fetch("location")
   Stage.new({:name => name, :id => id, :location => location})
  end

  def artists
    Artist.find_by_stage(self.id)
  end

  def update(name)
    @name = name
    DB.exec("UPDATE stages SET name = '#{@name}' WHERE id = #{@id};")
  end
end