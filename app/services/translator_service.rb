require 'net/http'

class TranslatorService
  def self.translate(text, dialect)
    uri = URI("http://api.funtranslations.com/translate/#{dialect}.json")
    res = Net::HTTP.post_form(uri, text: text)
    JSON.parse(res.body)["contents"]["translated"]
  end
end
