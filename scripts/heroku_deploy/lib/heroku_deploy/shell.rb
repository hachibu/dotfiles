require 'term/ansicolor'

module HerokuDeploy
  module Shell
    def system!(command, dry_run: false)
      if dry_run
        puts command
      else
        system(command) || abort
      end
    end

    def error!(message)
      abort(Term::ANSIColor.red("Error: #{message}"))
    end

    def git_repository?
      Dir.exist?('.git')
    end
  end
end
