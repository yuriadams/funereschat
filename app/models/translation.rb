class Translation
  def initialize success, contents
    @success = success
    @contents = contents
  end

  def text
    @contents.translated
  end
end
