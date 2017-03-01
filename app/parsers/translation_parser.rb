class TranslationParser
  def self.parse json_content
    success = SuccessParser.parse(json_content.fetch('success', {}))
    contents = ContentsParser.parse(json_content.fetch('contents', {}))

    Translation.new(success, contents)
  end
end
