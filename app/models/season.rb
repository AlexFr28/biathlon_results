class Season

  attr_accessor :id
  attr_accessor :name
  attr_accessor :events

  def self.find(season_id)
    if check_season_id(season_id)
      Season.new(season_id)
    else
      nil
    end
  end

  def self.current_season_id
    prev_year = Date.today.prev_year.strftime("%y")
    current_year = Date.today.strftime("%y")
    next_year = Date.today.next_year.strftime("%y")

    Date.today.month < 10 ? "#{prev_year}#{current_year}" : "#{current_year}#{next_year}"
  end

  def initialize(season_id)
      @id = season_id
      @name = get_name(season_id)
      @events = get_events
  end

  private

  def self.check_season_id(season_id)
    return false if season_id.nil?
    return false if season_id.length != 4
    start_year = season_id.first(2)
    end_year = season_id.last(2)
    return false if start_year.to_i != end_year.to_i - 1
    true
  end

  def get_name(season_id)
    start_year = season_id.first(2)
    end_year = season_id.last(2)
    "20#{start_year}-20#{end_year}"
  end

  def get_events
    result = []
    events = BiathlonResults::Service.new.events(season_id: id, level: BiathlonResults::LEVEL[:"BMW IBU WC"])
    events.each do |event|
      result << Event.new(
        ibu_id:            event["EventId"],
        short_nationality: event["Nat"],
        nationality:       event["NatLong"],
        location:          event["ShortDescription"],
        start_date:        event["StartDate"],
        end_date:          event["EndDate"],
        etat:              event["EventSeriesNr"],
        description:       event["Description"]
      )
    end
    result
  end

end
