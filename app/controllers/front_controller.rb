require 'BiathlonResults'

class FrontController < ApplicationController
  layout "application"
  before_action :set_body_classes, only: [:home, :race]

  def home
    @events = biathlon_api_service.events(season_id: "2021", level: BiathlonResults::LEVEL[:"BMW IBU WC"])
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

  private

  def set_body_classes
    @body_classes = params[:action]
  end

  def biathlon_api_service
    BiathlonResults::Service.new
  end
end
