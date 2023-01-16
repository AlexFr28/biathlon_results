class Competition

  attr_accessor :ibu_id
  attr_accessor :category
  attr_accessor :discipline
  attr_accessor :description
  attr_accessor :date
  attr_accessor :results

  CATEGORY_FOR_DISPLAY = [
    "SM", # Single men
    "SW", # Single women
  ]

  DISCIPLINE_FOR_DISPLAY = HashWithIndifferentAccess.new(
    "IN": "Individual",
    "SP": "Sprint",
    "PU": "Pursuit",
    "RL": "Relay",
    "MS": "Mass Start"
  )

  def initialize(ibu_id:, category: nil, discipline: nil, description: nil, date: nil)
    @ibu_id = ibu_id
    @category = category
    @discipline = discipline
    @description = description
    @date = date
    @results = []

    # get_results
  end

  def to_s
    DISCIPLINE_FOR_DISPLAY[discipline]
  end

  def get_results
    ibu_results = BiathlonResults::Service.new.results(race_id: ibu_id)
    ibu_results["Results"].each do |ibu_result|
      result = {ibu_athlete_id: ibu_result["IBUId"], name: ibu_result["Name"], point: ibu_result["WC"], rank: ibu_result["Rank"]}
      @results << result
    end
  end

end

__END__

{
              "StartOrder" => 37,
             "ResultOrder" => 1,
                     "IRM" => nil,
                   "IBUId" => "BTNOR12002199701",
                    "Name" => "LAEGREID Sturla Holm",
               "ShortName" => "LAEGREID S.",
                     "Nat" => "NOR",
                     "Bib" => "37",
                     "Leg" => nil,
                    "Rank" => "1",
               "Shootings" => "0+0+0+0",
           "ShootingTotal" => "0",
                 "RunTime" => nil,
               "TotalTime" => "48:57.0",
                      "WC" => "60",
                      "NC" => "160",
                     "NOC" => nil,
               "StartTime" => "2020-11-28T10:18:30Z",
               "StartInfo" => "12:18:30",
                "StartRow" => 0,
               "StartLane" => 0,
                "BibColor" => nil,
                  "Behind" => "0.0",
              "StartGroup" => nil,
                  "TeamId" => nil,
    "PursuitStartDistance" => 0,
                  "Result" => "48:57.0",
                 "LegRank" => nil,
        "TeamRankAfterLeg" => nil
}

{
               "RaceId" => "BT2021SWRLCP01SMIN",
                   "km" => "20",
                "catId" => "SM",
         "DisciplineId" => "IN",
             "StatusId" => 11,
           "StatusText" => "Final",
          "HasLiveData" => false,
               "IsLive" => false,
            "StartTime" => "2020-11-28T10:00:00Z",
          "Description" => "Men 20km Individual Competition",
     "ShortDescription" => "Men 20km Individual",
             "Location" => "Biathlon Stadium Kontiolahti",
        "ResultsCredit" => nil,
         "TimingCredit" => nil,
          "HasAnalysis" => true,
            "StartMode" => "I",
          "NrShootings" => 4,
        "NrSpareRounds" => 0,
       "HasSpareRounds" => false,
       "PenaltySeconds" => 60,
               "NrLegs" => 0,
    "ShootingPositions" => "PSPS",
       "LocalUTCOffset" => 2,
                  "RSC" => "BTHM20KMIS------------FNL-000100--",
          "GenderOrder" => nil
}
