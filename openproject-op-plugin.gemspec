$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'open_project/op_plugin/version'

Gem::Specification.new do |s|
  s.name        = 'openproject-op-plugin'
  s.version     = OpenProject::OpPlugin::VERSION
  s.authors     = ['drake.lee']
  s.email       = ['hnabyz2023@gmail.com']
  s.homepage    = 'https://github.com/your-org/openproject-op-plugin'
  s.summary     = 'OpenProject op-plugin'
  s.description = 'OpenProject plugin: op-plugin — extends OpenProject with custom functionality.'
  s.license     = 'GPL-3.0'

  s.required_ruby_version = '>= 3.1'

  s.files = Dir['{app,config,db,doc,frontend,lib}/**/*'] +
            %w[CHANGELOG.md README.md openproject-op-plugin.gemspec]

  s.add_dependency 'openproject-plugins', '>= 15.0.0'
  s.add_development_dependency 'rake'
end
