# coding: UTF-8

module BiathlonResults
  ROOT_API = 'http://biathlonresults.com/modules/sportapi/api'

  LEVEL = {
    "all": 0,
    "BMW IBU WC": 1,
    "IBU Cup": 2,
    "Jr. Cup": 3
  }

  class Service

    def cups(season_id:)
      get("Cups", "#{ROOT_API}/Cups?SeasonId=#{season_id}&Level=1")
    end

    def events(season_id:, level: 0)
      get("Events", "#{ROOT_API}/Events?SeasonId=#{season_id}&Level=#{level}")
    end

    def competitions(event_id:)
      get("Competitions", "#{ROOT_API}/Competitions?EventId=#{event_id}")
    end

    def results(race_id:)
      get("Results", "#{ROOT_API}/Results?RaceId=#{race_id}")
    end

    private

    def get(type, request_url)
      begin
        Rails.logger.info("BiathlonResults::#{type} GET #{request_url}")
        response = RestClient.get(request_url)
      rescue RestClient::Unauthorized, RestClient::Forbidden => err
        Rails.logger.info("Access denied")
        Rails.logger.info(err.response)
      rescue EOFError => e
        Rails.logger.info("EOF error when reading BiathlonResults answer")
        Rails.logger.info("message : #{e.message}")
      else
        case response.code
        when 200
          Rails.logger.info("BiathlonResults::#{type} response #{response.class}")
          Rails.logger.info(response.body)
          return JSON.parse(response.body)
        else
          Rails.logger.info("HTTP response code: #{response.code}")
        end
      end
    end

  end

end
