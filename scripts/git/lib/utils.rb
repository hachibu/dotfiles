require_relative 'core_ext/string'

def error(message)
  puts(message.to_s.red)
  exit(1)
end

def git(*commands)
  commands.each do |command|
    command = "git #{command}"
    if system("#{command} --quiet")
      puts('✓'.green + " #{command}")
    else
      puts('☓'.red + " #{command}")
      exit(1)
    end
  end
end

def git_branch
  `git rev-parse --abbrev-ref HEAD`.strip
end

def git_repo?
  Dir.exist?('.git')
end

def check_git_repo!
  error('Not a git repository.') unless git_repo?
end
