require 'thor'
require_relative 'config'
require_relative 'shell'

include HerokuDeploy::Shell

error!('Not a git repository.') unless git_repository?

CONFIG = HerokuDeploy::Config.new

unless CONFIG.valid?
  error!("Config file missing. Expecting `#{CONFIG.path}` to exist.")
end

GIT_REMOTES = CONFIG.fetch('git_remotes')
GIT_REMOTE_NAMES = GIT_REMOTES.map { |r| r.fetch('name') }

module HerokuDeploy
  class CLI < Thor
    include HerokuDeploy::Shell

    GIT_REMOTE_NAMES.each do |name|
      desc name, "Deploy to #{name}"
      method_option :dry_run, type: :boolean, default: false, aliases: :d
      define_method name do
        branch = `git symbolic-ref HEAD --short`.strip
        remote = name
        git_remote = GIT_REMOTES.find { |gr| gr['name'] == remote }
        allow_git_force_push = git_remote.fetch('allow_git_force_push', false)
        git_push_flags = allow_git_force_push ? '--force' : nil

        unless allow_git_force_push
          error!("Deploying to #{remote}/master is only allowed from master.")
        end

        dry_run = options[:dry_run]

        CONFIG.exec_hook!('before_git_push', dry_run: dry_run)
        system!(
          "git push #{git_push_flags} #{remote} #{branch}:master",
          dry_run: dry_run
        )
        CONFIG.exec_hook!('after_git_push', dry_run: dry_run)
        CONFIG.exec_hook!('before_heroku_restart', dry_run: dry_run)
        system!("heroku restart --remote #{remote}", dry_run: dry_run)
        CONFIG.exec_hook!('after_heroku_restart', dry_run: dry_run)
      end
    end
  end
end

HerokuDeploy::CLI.start(ARGV)
