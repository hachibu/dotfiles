require "./timeout/*"
require "option_parser"

def parse_timespan!(s)
  span = [:h, :m, :s].zip(s.split(":").map { |n| n.to_i }).to_h
  Time::Span.new(span[:h], span[:m], span[:s])
end

def log(message)
  STDOUT.puts %([#{Time.now}] #{message})
end

def die(message, exit_code = 1)
  STDERR.puts("error: #{message}")
  exit(exit_code)
end

timespan : Time::Span = Time::Span.new(0, 20, 0)

OptionParser.parse! do |p|
  p.banner = "usage: timeout [options]"

  p.on("-t t", "--timespan=t", "default is 00:20:00") do |s|
    timespan = parse_timespan!(s)
  rescue
    die("invalid timespan")
  end
  p.on("-h", "--help", "show help") { puts p }

  p.invalid_option do |flag|
    die("invalid option: #{flag}")
  end

  p.missing_option do |flag|
    die("missing argument: #{flag}")
  end
end

timer = Timeout::Timer.new(timespan)
notification = Timeout::Notification.new(
  title: "Timeout",
  message: "Take a break."
)
timer.on Timeout::Event::Complete, ->(t : Timeout::Timer) do
  notification.display
end

[Signal::INT, Signal::TERM].each { |s| s.trap { log("Stop"); exit } }

log("Start")
timer.start
sleep
