class ApplicationController < ActionController::Base

  def get_current_season
    @current_season ||= Season.new(:current)
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
