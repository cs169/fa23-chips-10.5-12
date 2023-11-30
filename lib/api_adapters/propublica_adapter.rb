# frozen_string_literal: true

class PropublicaAPIAdapter
  API_VERSION   = 'v1'
  API_BASE_URL  = "https://api.propublica.org/campaign-finance/#{self::API_VERSION}/"
  START_CYCLE   = 1996
  CURRENT_CYCLE = 2018
end
