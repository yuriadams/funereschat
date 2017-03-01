class ContentsParser
  def self.parse json_content
    Contents.new(json_content.fetch('translated', ''),
                 json_content.fetch('text', ''),
                 json_content.fetch('translation', ''))
  end
end
