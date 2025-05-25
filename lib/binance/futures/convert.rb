# frozen_string_literal: true

module Binance
  class Futures
    # Module for handling futures convert operations including quote requests,
    # order status, and convert pairs information.
    module Convert
      # Accept the offered quote by quote ID.
      # Weight: 200(IP)
      def accept_the_offered_quote(quote_id:, recv_window: nil)
        params = {
          quoteId: quote_id,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:post, '/fapi/v1/convert/acceptQuote', params: params)
      end

      # Query for all convertible token pairs and the tokens' respective upper/lower limits
      # User needs to supply either or both of the input parameter
      # If not defined for both fromAsset and toAsset, only partial token pairs will be returned
      # Asset BNFCR is only available to convert for MICA region users.
      # Weight: 20(IP)
      def list_all_convert_pairs(from_asset: nil, to_asset: nil)
        params = {
          fromAsset: from_asset,
          toAsset: to_asset
        }.compact

        @session.sign_request(:get, '/fapi/v1/convert/exchangeInfo', params: params)
      end

      # Query order status by order ID.
      # Weight: 50(IP)
      def order_status(order_id: nil, quote_id: nil)
        params = {
          orderId: order_id,
          quoteId: quote_id
        }.compact

        @session.sign_request(:get, '/fapi/v1/convert/orderStatus', params: params)
      end

      # Request a quote for the requested token pairs
      # Either fromAmount or toAmount should be sent
      # `quoteId` will be returned only if you have enough funds to convert
      # Weight: 50(IP)
      def send_quote_request(from_asset:, to_asset:, from_amount: nil, to_amount: nil, valid_time: nil, recv_window: nil)
        params = {
          fromAsset: from_asset,
          toAsset: to_asset,
          fromAmount: from_amount,
          toAmount: to_amount,
          validTime: valid_time,
          recvWindow: recv_window
        }.compact

        @session.sign_request(:post, '/fapi/v1/convert/getQuote', params: params)
      end
    end
  end
end
