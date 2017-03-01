class SucessParser
  def self.parse json_content
    Success.new(json_content.fetch('contents', ''))
  end
end
