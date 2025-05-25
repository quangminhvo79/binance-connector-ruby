# frozen_string_literal: true

module Binance
  class Futures
    # Module for handling futures account operations including account information,
    # balance, configuration, and trading rules.
    module Account
      # Get current account information. User in single-asset/ multi-assets mode will see different value.
      # Weight: 5
      def account_information_v2(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v2/account', params: params)
      end

      # Get current account information. User in single-asset/ multi-assets mode will see different value.
      # Weight: 5
      def account_information_v3(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v3/account', params: params)
      end

      # Query account balance info
      # Weight: 5
      def futures_account_balance_v2(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v2/balance', params: params)
      end

      # Query account balance info
      # Weight: 5
      def futures_account_balance_v3(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v3/balance', params: params)
      end

      # Query account configuration
      # Weight: 5
      def futures_account_configuration(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v1/accountConfig', params: params)
      end

      # Futures trading quantitative rules indicators
      # Weight: - 1 for a single symbol
      # - 10 when the symbol parameter is omitted
      def futures_trading_quantitative_rules_indicators(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/apiTradingStatus', params: params)
      end

      # Get user's BNB Fee Discount (Fee Discount On or Fee Discount Off)
      # Weight: 30
      def get_bnb_burn_status(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v1/feeBurn', params: params)
      end

      # Get user's Multi-Assets mode (Multi-Assets Mode or Single-Asset Mode) on Every symbol
      # Weight: 30
      def get_current_multi_assets_mode(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v1/multiAssetsMargin', params: params)
      end

      # Get user's position mode (Hedge Mode or One-way Mode) on EVERY symbol
      # Weight: 30
      def get_current_position_mode(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v1/positionSide/dual', params: params)
      end

      # Get Download Id For Futures Order History
      # Request Limitation is 10 times per month
      # Weight: 1000
      def get_download_id_for_futures_order_history(start_time:, end_time:, recv_window: nil)
        params = {
          startTime: start_time,
          endTime: end_time,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/order/asyn', params: params)
      end

      # Get download id for futures trade history
      # Request Limitation is 5 times per month
      # Weight: 1000
      def get_download_id_for_futures_trade_history(start_time:, end_time:, recv_window: nil)
        params = {
          startTime: start_time,
          endTime: end_time,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/trade/asyn', params: params)
      end

      # Get download id for futures transaction history
      # Request Limitation is 5 times per month
      # Weight: 1000
      def get_download_id_for_futures_transaction_history(start_time:, end_time:, recv_window: nil)
        params = {
          startTime: start_time,
          endTime: end_time,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/income/asyn', params: params)
      end

      # Get futures order history download link by Id
      # Download link expiration: 24h
      # Weight: 10
      def get_futures_order_history_download_link_by_id(download_id:, recv_window: nil)
        params = {
          downloadId: download_id,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/order/asyn/id', params: params)
      end

      # Get futures trade download link by Id
      # Download link expiration: 24h
      # Weight: 10
      def get_futures_trade_download_link_by_id(download_id:, recv_window: nil)
        params = {
          downloadId: download_id,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/trade/asyn/id', params: params)
      end

      # Get futures transaction history download link by Id
      # Download link expiration: 24h
      # Weight: 10
      def get_futures_transaction_history_download_link_by_id(download_id:, recv_window: nil)
        params = {
          downloadId: download_id,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/income/asyn/id', params: params)
      end

      # Query income history
      # Weight: 30
      def get_income_history(symbol: nil, income_type: nil, start_time: nil, end_time: nil, page: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          incomeType: income_type,
          startTime: start_time,
          endTime: end_time,
          page: page,
          limit: limit,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/income', params: params)
      end

      # Query user notional and leverage bracket on specific symbol
      # Weight: 1
      def notional_and_leverage_brackets(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/leverageBracket', params: params)
      end

      # Query User Rate Limit
      # Weight: 1
      def query_user_rate_limit(recv_window: nil)
        params = { recvWindow: recv_window }.compact
        @session.sign_request(:get, '/fapi/v1/rateLimit/order', params: params)
      end

      # Get current account symbol configuration.
      # Weight: 5
      def symbol_configuration(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/symbolConfig', params: params)
      end

      # Change user's BNB Fee Discount (Fee Discount On or Fee Discount Off) on EVERY symbol
      # Weight: 1
      def toggle_bnb_burn_on_futures_trade(fee_burn:, recv_window: nil)
        params = {
          feeBurn: fee_burn,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:post, '/fapi/v1/feeBurn', params: params)
      end

      # Get User Commission Rate
      # Weight: 20
      def user_commission_rate(symbol:, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/commissionRate', params: params)
      end
    end
  end
end
