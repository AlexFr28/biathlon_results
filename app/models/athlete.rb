class Athlete

  @@all = []
  attr_accessor :ibu_id
  attr_accessor :name
  attr_accessor :nationality
  attr_accessor :results
  attr_reader   :total_points

  def self.all
    @@all
  end

  def initialize(ibu_id:, name:, nationality:)
    athlete = find(ibu_id: ibu_id)
    if athlete.nil?
      @ibu_id = ibu_id
      @name = name
      @nationality = nationality
      @results = {}
      @total_points = 0
      @@all << self
      self
    else
      athlete
    end
  end

  def add_result(race_id:, rank:, points:)
    @results[race_id] = [rank, points]
    @total_points += points
  end

  def find(ibu_id:)
    @@all.select{|athlete| athlete.ibu_id == ibu_id}.first
  end

end
