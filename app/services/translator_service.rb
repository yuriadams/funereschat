require 'net/http'

class TranslatorService
  def self.translate(text, dialect)
    TranslationParser.parse(JSON.parse(make_request(text, dialect)))
  end

  def self.make_request text, dialect
    uri = URI("http://api.funtranslations.com/translate/#{dialect}.json")
    Net::HTTP.post_form(uri, text: text).body
  end
end
