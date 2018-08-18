require "./*"

class Timeout::Timer
  property :interval, :last_completed

  def initialize(
    @interval : Time::Span,
    @last_completed : Time = Time.now
  )
    @callbacks = {} of Timeout::Event => Array(Timeout::Callback)

    @callbacks[Timeout::Event::Complete] = [] of Timeout::Callback
  end

  def on(event : Timeout::Event, callback : Timeout::Callback)
    @callbacks[event].push(callback)
  end

  def trigger(event : Timeout::Event)
    @callbacks[event].each { |proc| proc.call(self) }
  end

  def start
    spawn do
      loop do
        if complete?
          trigger(Timeout::Event::Complete)
        end
        sleep(1.second)
      end
    end
  end

  def complete? : Bool
    time_now = Time.now
    if time_now - @last_completed >= @interval
      @last_completed = time_now
      true
    else
      false
    end
  end
end
