# frozen_string_literal: true

require 'uri'
require 'net/http'

module Noti
  class Exponent
    PUSH_URL = 'https://exp.host/--/api/v2/push/send'
    BLOCK_SIZE = 100

    attr_reader :uri, :http, :request, :message

    def initialize(message)
      @message = message

      @uri = URI.parse(PUSH_URL)

      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true

      @request = Net::HTTP::Post.new(@uri.path)
      @request['Content-Type'] = 'application/json'
    end

    def send_to(tokens)
      if tokens.is_a?(Array)
        tokens.each_slice(BLOCK_SIZE) do |token_block|
          @request.body = message.merge(to: token_block).to_json
          @http.request(@request)
        end
      else
        @request.body = message.merge(to: tokens).to_json
        @http.request(@request)
      end
    end
  end
end
