require 'BiathlonResults'

class FrontController < ApplicationController
  layout "application"
  before_action :set_body_classes, only: [:home, :race, :standings]

  AVAILABLE_GENDERS = [:men, :women]

  def home
    @current_year = Date.today.strftime("%Y").to_i
    @options_for_select = options_for_select_season_ids

    @selected_season_id = if params[:season].present?
      if check_season(params[:season])
        get_season(params[:season])
        params[:season]
      else
        redirect_to root_path
      end
    else
      Season.current_season_id
    end
  end

  def competitions_of_event
    @element_id = params[:element_id]
    @competitions = biathlon_api_service.competitions(event_id: params[:event_id])

    respond_to do |format|
      format.js {
        render :competitions_of_event, layout: false
      }
    end
  end

  def race
    @race = biathlon_api_service.results(race_id: params[:race_id])
  end

  def standings
    @standings = true
    get_current_season
    @gender = params[:gender].to_sym
  end

  def add_results
    respond_to do |format|
      format.json do
        competition = Competition.new(ibu_id: params[:ibu_id])
        competition.get_results

        render json: competition.results.first(5).to_json
      end
    end
  end

  private

  def set_body_classes
    @body_classes = params[:action]
  end

  def biathlon_api_service
    BiathlonResults::Service.new
  end
end
