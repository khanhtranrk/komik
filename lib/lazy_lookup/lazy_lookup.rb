# frozen_string_literal: true

module LazyLookup
  def t(key, **options)
    path = caller.first
    if %r{^.+?app/(controllers|models|services)/(.+?)(_controller|).rb.+?`.*?([^\s]+)'} =~ path
      type_name = Regexp.last_match[1]
      super_class = Regexp.last_match[2]
      method_name = Regexp.last_match[4]

      if I18n.exists?("#{type_name}.#{super_class.gsub('/', '.')}.#{method_name}.#{key}", **options)
        I18n.t("#{type_name}.#{super_class.gsub('/', '.')}.#{method_name}.#{key}", **options)
      else
        I18n.t("common.#{key}", **options)
      end
    else
      I18n.t(key, **options)
    end
  end
end
