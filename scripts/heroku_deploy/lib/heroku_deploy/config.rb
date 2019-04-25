require 'yaml'
require_relative 'shell'

module HerokuDeploy
  class Config
    include HerokuDeploy::Shell

    def initialize
      @config = YAML.load_file(path) rescue nil
    end

    def path
      File.join(Dir.pwd, '.heroku', 'deploy.yml')
    end

    def valid?
      @config != nil
    end

    def dig(*args)
      @config.dig(*args)
    end

    def fetch(key)
      @config.fetch(key)
    end

    def exec_hook!(name, dry_run: false)
      command = @config.dig('hooks', name)
      if command
        if dry_run
          puts command
        else
          system!(command)
        end
      end
    end
  end
end
