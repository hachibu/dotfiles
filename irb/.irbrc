require 'awesome_print'
require 'irb/completion'
require 'irb/ext/save-history'

AwesomePrint.irb!

IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')
IRB.conf[:PROMPT_MODE] = :SIMPLE
