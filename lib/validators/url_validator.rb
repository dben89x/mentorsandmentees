class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless parsable?(value)
      record.errors[attribute] << (options[:message] || "isn't a valid url. Try prefixing http:// or https://")
    end
  end

  def parsable?(url)
    begin
      URI.parse(url).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
  end
end
