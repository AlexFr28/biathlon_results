# coding: UTF-8

module BiathlonResults
  ROOT_API = 'http://biathlonresults.com/modules/sportapi/api/'
  LEVEL = {
    "all": 0,
    "BMW IBU WC": 1,
    "IBU Cup": 2,
    "Jr. Cup": 3
  }

  class Service

    def cups(season_id:)
      request_url = "#{ROOT_API}/Cups?SeasonId=#{season_id}&Level=1"
      begin
        Rails.logger.info("BiathlonResults::Cups GET #{request_url}")
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
          Rails.logger.info("BiathlonResults::Cups response #{response.class}")
          Rails.logger.info(response.body)
          return JSON.parse(response.body)
        else
          Rails.logger.info("HTTP response code: #{response.code}")
        end
      end
    end

    def events(season_id:, level: 0)
      request_url = "#{ROOT_API}/Events?SeasonId=#{season_id}&Level=#{level}"
      begin
        Rails.logger.info("BiathlonResults::Events GET #{request_url}")
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
          Rails.logger.info("BiathlonResults::Events response #{response.class}")
          Rails.logger.info(response.body)
          return JSON.parse(response.body)
        else
          Rails.logger.info("HTTP response code: #{response.code}")
        end
      end
    end

    def competitions(event_id:)
      request_url = "#{ROOT_API}/Competitions?EventId=#{event_id}"
      begin
        Rails.logger.info("BiathlonResults::Competitions GET #{request_url}")
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
          Rails.logger.info("BiathlonResults::Competitions response #{response.class}")
          Rails.logger.info(response.body)
          return JSON.parse(response.body)
        else
          Rails.logger.info("HTTP response code: #{response.code}")
        end
      end
    end

    def results(race_id:)
      request_url = "#{ROOT_API}/Results?RaceId=#{race_id}"
      begin
        Rails.logger.info("BiathlonResults::Results GET #{request_url}")
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
          Rails.logger.info("BiathlonResults::Results response #{response.class}")
          Rails.logger.info(response.body)
          return JSON.parse(response.body)
        else
          Rails.logger.info("HTTP response code: #{response.code}")
        end
      end
    end

  end

end
