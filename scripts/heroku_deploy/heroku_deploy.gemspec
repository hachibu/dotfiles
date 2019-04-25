Gem::Specification.new do |s|
  s.name        = 'heroku_deploy'
  s.version     = '0.0.0'
  s.executables << 'heroku-deploy'
  s.date        = '2010-04-28'
  s.summary     = 'Stop writing the same deploy script over and over.'
  s.description = 'A CLI for deploying to apps to Heroku'
  s.authors     = ['Ray Sohn']
  s.email       = 'ray@wootric.com'
  s.files       = [
    'lib/heroku_deploy.rb',
    'lib/heroku_deploy/cli.rb',
    'lib/heroku_deploy/config.rb',
    'lib/heroku_deploy/shell.rb'
  ]
  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
end
