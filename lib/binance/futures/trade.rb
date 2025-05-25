# frozen_string_literal: true

module Binance
  class Futures
    # Module for handling futures trading operations including order management,
    # position management, and account information.
    module Trade
      # Get trades for a specific account and symbol.
      # If start_time and end_time are both not sent, then the last 7 days' data will be returned.
      # The time between start_time and end_time cannot be longer than 7 days.
      # The parameter from_id cannot be sent with start_time or end_time.
      # Only support querying trade in the past 6 months
      # Weight: 5
      def account_trade_list(symbol:, order_id: nil, start_time: nil, end_time: nil, from_id: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          startTime: start_time,
          endTime: end_time,
          fromId: from_id,
          limit: limit,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/userTrades', params: params)
      end

      # Get all account orders; active, canceled, or filled.
      # Weight: 5
      def all_orders(symbol:, order_id: nil, start_time: nil, end_time: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          startTime: start_time,
          endTime: end_time,
          limit: limit,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:get, '/fapi/v1/allOrders', params: params)
      end

      # Cancel all open orders of the specified symbol at the end of the specified countdown.
      # Weight: 10
      def auto_cancel_all_open_orders(symbol:, countdown_time:, recv_window: nil)
        params = {
          symbol: symbol,
          countdownTime: countdown_time,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/countdownCancelAll', params: params)
      end

      # Cancel All Open Orders
      # Weight: 1
      def cancel_all_open_orders(symbol:, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        send_request(:delete, '/fapi/v1/allOpenOrders', params: params)
      end

      # Cancel Multiple Orders
      # Weight: 1
      def cancel_multiple_orders(symbol:, order_id_list: nil, orig_client_order_id_list: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderIdList: order_id_list,
          origClientOrderIdList: orig_client_order_id_list,
          recvWindow: recv_window
        }.compact

        send_request(:delete, '/fapi/v1/batchOrders', params: params)
      end

      # Cancel an active order.
      # Weight: 1
      def cancel_order(symbol:, order_id: nil, orig_client_order_id: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          origClientOrderId: orig_client_order_id,
          recvWindow: recv_window
        }.compact

        send_request(:delete, '/fapi/v1/order', params: params)
      end

      # Change user's initial leverage of specific symbol market.
      # Weight: 1
      def change_initial_leverage(symbol:, leverage:, recv_window: nil)
        params = {
          symbol: symbol,
          leverage: leverage,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/leverage', params: params)
      end

      # Change symbol level margin type
      # Weight: 1
      def change_margin_type(symbol:, margin_type:, recv_window: nil)
        params = {
          symbol: symbol,
          marginType: margin_type,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/marginType', params: params)
      end

      # Change user's Multi-Assets mode
      # Weight: 1
      def change_multi_assets_mode(multi_assets_margin:, recv_window: nil)
        params = {
          multiAssetsMargin: multi_assets_margin,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/multiAssetsMargin', params: params)
      end

      # Change user's position mode
      # Weight: 1
      def change_position_mode(dual_side_position:, recv_window: nil)
        params = {
          dualSidePosition: dual_side_position,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/positionSide/dual', params: params)
      end

      # Get all open orders on a symbol.
      # Weight: 1 for a single symbol; 40 when the symbol parameter is omitted
      def current_all_open_orders(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/openOrders', params: params)
      end

      # Get order modification history
      # Weight: 1
      def get_order_modify_history(symbol:, order_id: nil, orig_client_order_id: nil, start_time: nil, end_time: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          origClientOrderId: orig_client_order_id,
          startTime: start_time,
          endTime: end_time,
          limit: limit,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/orderAmendment', params: params)
      end

      # Get Position Margin Change History
      # Weight: 1
      def get_position_margin_change_history(symbol:, type: nil, start_time: nil, end_time: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          type: type,
          startTime: start_time,
          endTime: end_time,
          limit: limit,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/positionMargin/history', params: params)
      end

      # Modify Isolated Position Margin
      # Weight: 1
      def modify_isolated_position_margin(symbol:, amount:, type:, position_side: nil, recv_window: nil)
        params = {
          symbol: symbol,
          amount: amount,
          type: type,
          positionSide: position_side,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/positionMargin', params: params)
      end

      # Modify Multiple Orders
      # Weight: 5
      def modify_multiple_orders(batch_orders:, recv_window: nil)
        params = {
          batchOrders: batch_orders,
          recvWindow: recv_window
        }.compact

        send_request(:put, '/fapi/v1/batchOrders', params: params)
      end

      # Modify Order
      # Weight: 1
      def modify_order(symbol:, side:, quantity:, price:, order_id: nil, orig_client_order_id: nil, price_match: nil, recv_window: nil)
        params = {
          symbol: symbol,
          side: side,
          quantity: quantity,
          price: price,
          orderId: order_id,
          origClientOrderId: orig_client_order_id,
          priceMatch: price_match,
          recvWindow: recv_window
        }.compact

        send_request(:put, '/fapi/v1/order', params: params)
      end

      # New Order
      # Weight: 1
      def new_order(symbol:, side:, type:, position_side: nil, time_in_force: nil, quantity: nil, reduce_only: nil, price: nil, new_client_order_id: nil, stop_price: nil, close_position: nil, activation_price: nil, callback_rate: nil, working_type: nil, price_protect: nil, new_order_resp_type: nil, price_match: nil, self_trade_prevention_mode: nil, good_till_date: nil, recv_window: nil)
        params = {
          symbol: symbol,
          side: side,
          type: type,
          positionSide: position_side,
          timeInForce: time_in_force,
          quantity: quantity,
          reduceOnly: reduce_only,
          price: price,
          newClientOrderId: new_client_order_id,
          stopPrice: stop_price,
          closePosition: close_position,
          activationPrice: activation_price,
          callbackRate: callback_rate,
          workingType: working_type,
          priceProtect: price_protect,
          newOrderRespType: new_order_resp_type,
          priceMatch: price_match,
          selfTradePreventionMode: self_trade_prevention_mode,
          goodTillDate: good_till_date,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/order', params: params)
      end

      # Place Multiple Orders
      # Weight: 5
      def place_multiple_orders(batch_orders:, recv_window: nil)
        params = {
          batchOrders: batch_orders,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/batchOrders', params: params)
      end

      # Position ADL Quantile Estimation
      # Weight: 5
      def position_adl_quantile_estimation(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/adlQuantile', params: params)
      end

      # Get current position information.
      # Weight: 5
      def position_information_v2(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v2/positionRisk', params: params)
      end

      # Get current position information
      # Weight: 5
      def position_information_v3(symbol: nil, recv_window: nil)
        params = {
          symbol: symbol,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v3/positionRisk', params: params)
      end

      # Query open order
      # Weight: 1
      def query_current_open_order(symbol:, order_id: nil, orig_client_order_id: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          origClientOrderId: orig_client_order_id,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/openOrder', params: params)
      end

      # Check an order's status.
      # Weight: 1
      def query_order(symbol:, order_id: nil, orig_client_order_id: nil, recv_window: nil)
        params = {
          symbol: symbol,
          orderId: order_id,
          origClientOrderId: orig_client_order_id,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/order', params: params)
      end

      # Testing order request
      # Weight: 0
      def test_order(symbol:, side:, type:, position_side: nil, time_in_force: nil, quantity: nil, reduce_only: nil, price: nil, new_client_order_id: nil, stop_price: nil, close_position: nil, activation_price: nil, callback_rate: nil, working_type: nil, price_protect: nil, new_order_resp_type: nil, price_match: nil, self_trade_prevention_mode: nil, good_till_date: nil, recv_window: nil)
        params = {
          symbol: symbol,
          side: side,
          type: type,
          positionSide: position_side,
          timeInForce: time_in_force,
          quantity: quantity,
          reduceOnly: reduce_only,
          price: price,
          newClientOrderId: new_client_order_id,
          stopPrice: stop_price,
          closePosition: close_position,
          activationPrice: activation_price,
          callbackRate: callback_rate,
          workingType: working_type,
          priceProtect: price_protect,
          newOrderRespType: new_order_resp_type,
          priceMatch: price_match,
          selfTradePreventionMode: self_trade_prevention_mode,
          goodTillDate: good_till_date,
          recvWindow: recv_window
        }.compact

        send_request(:post, '/fapi/v1/order/test', params: params)
      end

      # Query user's Force Orders
      # Weight: 20 with symbol, 50 without symbol
      def users_force_orders(symbol: nil, auto_close_type: nil, start_time: nil, end_time: nil, limit: nil, recv_window: nil)
        params = {
          symbol: symbol,
          autoCloseType: auto_close_type,
          startTime: start_time,
          endTime: end_time,
          limit: limit,
          recvWindow: recv_window
        }.compact

        send_request(:get, '/fapi/v1/forceOrders', params: params)
      end
    end
  end
end
