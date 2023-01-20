class ApplicationController < ActionController::Base

  def get_current_season
    @current_season ||= Season.new(:current)
  end

  def get_season(season_id)
    @season = Season.new(season_id)
  end

  def check_season(season_id)
    return false if season_id.length != 4
    start_year = season_id.first(2)
    end_year = season_id.last(2)
    return false if start_year.to_i != end_year.to_i - 1
    "#{start_year % 100}#{end_year % 100}"
  end

  def options_for_select_season_ids
    result = []
    current_year = Date.today.strftime("%Y").to_i
    (2000..current_year - 1).each do |year|
      result << ["#{year}-#{year + 1}", "#{year.to_s.last(2)}#{(year + 1).to_s.last(2)}"]
    end
    result.reverse
  end

end
