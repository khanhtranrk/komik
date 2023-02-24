# frozen_string_literal: true

module Noti
  class Message
    attr_reader :title, :body, :data

    def initialize(**args)
      path = "noti.message_templates.#{args[:template] || 'default'}"

      @title = I18n.translate("#{path}.title", **args)
      @body = I18n.translate("#{path}.body", **args)

      @title = args[:title] if args[:title]
      @body = args[:body] if args[:body]
      @data = args[:data] if args[:data]
    end

    def as_json
      @data ? { title: @title, body: @body, data: @data } : { title: @title, body: @body }
    end

    def to_json(**options)
      as_json.to_json(**options)
    end
  end
end
