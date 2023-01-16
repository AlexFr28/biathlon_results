class Season

  attr_accessor :id
  attr_accessor :events

  def initialize(season_id)
    @id = stringify_season_id(season_id)
    @events = get_events
  end

  private

  def stringify_season_id(season_id)
    if season_id == :current
      prev_year = Date.today.prev_year.strftime("%y")
      current_year = Date.today.strftime("%y")
      next_year = Date.today.next_year.strftime("%y")

      Date.today.month < 10 ? "#{prev_year}#{current_year}" : "#{current_year}#{next_year}"
    else
      season_id
    end
  end

  def get_events
    result = []
    events = BiathlonResults::Service.new.events(season_id: id, level: BiathlonResults::LEVEL[:"BMW IBU WC"])
    events.each do |event|
      result << Event.new(
        ibu_id:      event["EventId"],
        short_nationality: event["Nat"],
        nationality: event["NatLong"],
        location:    event["ShortDescription"],
        start_date:  event["StartDate"],
        end_date:    event["EndDate"],
        etat:        event["EventSeriesNr"],
        description: event["Description"]
      )
    end
    result
  end

end
