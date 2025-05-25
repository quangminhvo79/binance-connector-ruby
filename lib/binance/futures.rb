# frozen_string_literal: true

require 'binance/session'
require 'binance/authentication'
require 'binance/utils/validation'
require 'binance/utils/url'
require 'binance/error'
require 'binance/futures/market'
require 'binance/futures/trade'
require 'binance/futures/convert'
require 'binance/futures/account'

module Binance
  # Spot class includes the following modules:
  # - Market
  # - Trade
  # - Convert
  # - Account
  class Futures
    include Binance::Futures::Market
    include Binance::Futures::Trade
    include Binance::Futures::Convert
    include Binance::Futures::Account

    FUTURES_BASE_URL = 'https://fapi.binance.com'

    def initialize(key: '', secret: '', **kwargs)
      @session = Session.new kwargs.merge(key: key, secret: secret, base_url: FUTURES_BASE_URL)
    end
  end
end
