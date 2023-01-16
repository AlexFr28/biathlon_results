class Event

  attr_accessor :ibu_id
  attr_accessor :short_nationality
  attr_accessor :nationality
  attr_accessor :location
  attr_accessor :competitions
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :etat
  attr_accessor :description

  def initialize(ibu_id:, short_nationality:, nationality:, location:, start_date:, end_date:, etat:, description:)
    @ibu_id = ibu_id
    @short_nationality = short_nationality
    @nationality = nationality
    @location = location
    @start_date = start_date
    @end_date = end_date
    @etat = etat
    @description = description
    @competitions = {men: [], women: []}

    get_competitions
  end

  def add_result(race_id:, rank:, points:)
    @results[race_id] = [rank, points]
    @total_points += points
  end

  private

  def get_competitions
    ibu_competitions = BiathlonResults::Service.new.competitions(event_id: ibu_id)
    ibu_competitions.each do |ibu_competition|
      competition = Competition.new(
        ibu_id:      ibu_competition["RaceId"],
        category:    ibu_competition["catId"],
        discipline:  ibu_competition["DisciplineId"],
        description: ibu_competition["ShortDescription"],
        date:        ibu_competition["StartTime"]
      )
      if ibu_competition["catId"] == "SM"
        @competitions[:men] << competition
      else
        @competitions[:women] << competition
      end
    end
  end

end

__END__

[ 0] {
                 "SeasonId" => "2021",
                "Trimester" => "1",
                  "EventId" => "BT2021SWRLCP01",
                "StartDate" => "2020-11-27T12:00:00Z",
                  "EndDate" => "2020-11-29T12:00:00Z",
              "Description" => "BMW IBU World Cup Biathlon-Season Opening",
            "EventSeriesNr" => "1 ",
         "ShortDescription" => "Kontiolahti",
              "OrganizerId" => "KON",
                "Organizer" => "Kontiolahti",
                      "Nat" => "FIN",
                  "NatLong" => "Finland",
               "MedalSetId" => nil,
    "EventClassificationId" => "BTSWRLCP",
                    "Level" => 1,
                "UTCOffset" => 2,
                 "IsActual" => false,
                "IsCurrent" => false
},
