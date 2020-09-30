class Stage
  attr_accessor :name, :location, :id

  @@stages = {}
  @@rows = 0
  

  def initialize(name, location, id)
    @name = name
    @location = location
    @id = id || @@rows += 1
  end

  def self.all()
    @@stages.values
  end

  def save
    @@stages[self.id] = Stage.new(self.name, self.location, self.id)
  end

  def delete
    @@stages.delete(self.id)
  end

  def == (param)
    self.name() == param.name()
  end

  def self.clear
    @@stages = {}
    @@rows = 0
  end

  def self.find(id)
    @@stages[id]
  end

  def artists
    Artist.find_by_stage(self.id)
  end
end