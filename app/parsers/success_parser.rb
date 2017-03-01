class SuccessParser
  def self.parse json_content
    Success.new(json_content.fetch('success', ''))
  end
end
