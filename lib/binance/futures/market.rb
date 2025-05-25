# frozen_string_literal: true

module Binance
  class Futures
    # Module for handling futures market data operations including price information,
    # order book data, klines/candlesticks, and market statistics.
    module Market
      # Query future basis
      # If start_time and end_time are not sent, the most recent data is returned.
      # Only the data of the latest 30 days is available.
      # Weight: 0
      def basis(pair:, contract_type:, period:, limit: 30, start_time: nil, end_time: nil)
        params = {
          pair: pair,
          contractType: contract_type,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/basis', params: params)
      end

      # Test connectivity to the Rest API and get the current server time.
      # Weight: 1
      def check_server_time
        @session.public_request(:get, '/fapi/v1/time')
      end

      # Query composite index symbol information
      # Only for composite index symbols
      # Weight: 1
      def composite_index_symbol_information(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/indexInfo', params: params)
      end

      # Get compressed, aggregate market trades.
      # Weight: 20
      def compressed_aggregate_trades_list(symbol:, from_id: nil, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          fromId: from_id,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/aggTrades', params: params)
      end

      # Kline/candlestick bars for a specific contract type.
      # Weight: based on parameter LIMIT
      def continuous_contract_kline_candlestick_data(pair:, contract_type:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          pair: pair,
          contractType: contract_type,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/continuousKlines', params: params)
      end

      # Current exchange trading rules and symbol information
      # Weight: 1
      def exchange_information
        @session.public_request(:get, '/fapi/v1/exchangeInfo')
      end

      # Get Funding Rate History
      # Weight: share 500/5min/IP rate limit with GET /fapi/v1/fundingInfo
      def get_funding_rate_history(symbol: nil, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/fundingRate', params: params)
      end

      # Get Funding Rate Info
      # Weight: 0
      def get_funding_rate_info
        @session.public_request(:get, '/fapi/v1/fundingInfo')
      end

      # Historical BLVT NAV Kline/Candlestick
      # Weight: 1
      def historical_blvt_nav_kline_candlestick(symbol:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/lvtKlines', params: params)
      end

      # Index Price Kline/Candlestick Data
      # Weight: based on parameter LIMIT
      def index_price_kline_candlestick_data(pair:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          pair: pair,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/indexPriceKlines', params: params)
      end

      # Kline/Candlestick Data
      # Weight: based on parameter LIMIT
      def kline_candlestick_data(symbol:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/klines', params: params)
      end

      # Long/Short Ratio
      # Weight: 0
      def long_short_ratio(symbol:, period:, limit: 100, start_time: nil, end_time: nil)
        params = {
          symbol: symbol,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/globalLongShortAccountRatio', params: params)
      end

      # Mark Price and Funding Rate
      # Weight: 1
      def mark_price(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/premiumIndex', params: params)
      end

      # Mark Price Kline/Candlestick Data
      # Weight: based on parameter LIMIT
      def mark_price_kline_candlestick_data(symbol:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/markPriceKlines', params: params)
      end

      # Multi-Assets Mode Asset Index
      # Weight: 1 for a single symbol; 10 when the symbol parameter is omitted
      def multi_assets_mode_asset_index(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/assetIndex', params: params)
      end

      # Old Trades Lookup
      # Weight: 20
      def old_trades_lookup(symbol:, limit: 100, from_id: nil)
        params = {
          symbol: symbol,
          limit: limit,
          fromId: from_id
        }.compact

        @session.public_request(:get, '/fapi/v1/historicalTrades', params: params)
      end

      # Open Interest
      # Weight: 1
      def open_interest(symbol:)
        params = { symbol: symbol }
        @session.public_request(:get, '/fapi/v1/openInterest', params: params)
      end

      # Open Interest Statistics
      # Weight: 0
      def open_interest_statistics(symbol:, period:, limit: 100, start_time: nil, end_time: nil)
        params = {
          symbol: symbol,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/openInterestHist', params: params)
      end

      # Order Book
      # Weight: Adjusted based on the limit
      def order_book(symbol:, limit: 100)
        params = {
          symbol: symbol,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/depth', params: params)
      end

      # Premium index Kline Data
      # Weight: based on parameter LIMIT
      def premium_index_kline_data(symbol:, interval:, start_time: nil, end_time: nil, limit: 100)
        params = {
          symbol: symbol,
          interval: interval,
          startTime: start_time,
          endTime: end_time,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/premiumIndexKlines', params: params)
      end

      # Quarterly Contract Settlement Price
      # Weight: 0
      def quarterly_contract_settlement_price(pair:)
        params = { pair: pair }
        @session.public_request(:get, '/futures/data/delivery-price', params: params)
      end

      # Query Index Price Constituents
      # Weight: 2
      def query_index_price_constituents(symbol:)
        params = { symbol: symbol }
        @session.public_request(:get, '/fapi/v1/constituents', params: params)
      end

      # Query Insurance Fund Balance Snapshot
      # Weight: 1
      def query_insurance_fund_balance_snapshot(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/insuranceFund', params: params)
      end

      # Recent Trades List
      # Weight: 5
      def recent_trades_list(symbol:, limit: 100)
        params = {
          symbol: symbol,
          limit: limit
        }.compact

        @session.public_request(:get, '/fapi/v1/trades', params: params)
      end

      # Symbol Order Book Ticker
      # Weight: 2 for a single symbol; 5 when the symbol parameter is omitted
      def symbol_order_book_ticker(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/ticker/bookTicker', params: params)
      end

      # Symbol Price Ticker
      # Weight: 1 for a single symbol; 2 when the symbol parameter is omitted
      def symbol_price_ticker(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/ticker/price', params: params)
      end

      # Symbol Price Ticker V2
      # Weight: 1 for a single symbol; 2 when the symbol parameter is omitted
      def symbol_price_ticker_v2(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v2/ticker/price', params: params)
      end

      # Taker Buy/Sell Volume
      # Weight: 0
      def taker_buy_sell_volume(symbol:, period:, limit: 100, start_time: nil, end_time: nil)
        params = {
          symbol: symbol,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/takerlongshortRatio', params: params)
      end

      # Test connectivity to the Rest API.
      # Weight: 1
      def test_connectivity
        @session.public_request(:get, '/fapi/v1/ping')
      end

      # 24hr Ticker Price Change Statistics
      # Weight: 1 for a single symbol; 40 when the symbol parameter is omitted
      def ticker_24hr_price_change_statistics(symbol: nil)
        params = { symbol: symbol }.compact
        @session.public_request(:get, '/fapi/v1/ticker/24hr', params: params)
      end

      # Top Trader Long/Short Ratio (Accounts)
      # Weight: 0
      def top_trader_long_short_ratio_accounts(symbol:, period:, limit: 100, start_time: nil, end_time: nil)
        params = {
          symbol: symbol,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/topLongShortAccountRatio', params: params)
      end

      # Top Trader Long/Short Ratio (Positions)
      # Weight: 0
      def top_trader_long_short_ratio_positions(symbol:, period:, limit: 100, start_time: nil, end_time: nil)
        params = {
          symbol: symbol,
          period: period,
          limit: limit,
          startTime: start_time,
          endTime: end_time
        }.compact

        @session.public_request(:get, '/futures/data/topLongShortPositionRatio', params: params)
      end
    end
  end
end
