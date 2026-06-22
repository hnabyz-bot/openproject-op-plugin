# Rails helper for OpenProject plugin integration specs.
# Requires $OPENPROJECT_ROOT to be set to the OpenProject core directory.
#
# Usage: OPENPROJECT_ROOT=/path/to/openproject bundle exec rspec spec/features/

require 'spec_helper'

openproject_root = ENV.fetch('OPENPROJECT_ROOT') do
  raise 'Set OPENPROJECT_ROOT to the OpenProject core directory before running integration specs.'
end

$LOAD_PATH.unshift(File.join(openproject_root, 'spec'))
require 'spec_helper'

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Shoulda::Matchers::ActiveModel, type: :model

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
