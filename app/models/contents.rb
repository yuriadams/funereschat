class Contents
  attr_reader :translated

  def initialize translated, text, translation
    @translated  = translated
    @text        = text
    @translation = translation
  end
end
