require "./timer"

module Timeout
  alias Callback = Proc(Timeout::Timer, Nil)
end
