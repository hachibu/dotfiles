class Timeout::Notification
  def initialize(
    @title : String,
    @message : String
  )
  end

  def display
    applescript = squish %(
      display notification "#{@message}"
              with title "#{@title}"
              sound name "default"
    )
    system("osascript -e '#{applescript}'")
  end

  private def squish(str : String)
    str.gsub("\n", "").squeeze.strip
  end
end
