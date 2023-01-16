class ApplicationController < ActionController::Base

  def get_current_season
    @current_season ||= Season.new(:current)
  end

end
