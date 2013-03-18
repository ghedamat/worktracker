require 'bundler'
require 'bundler/setup'

require 'worktracker'

RSpec.configure do |config|
  include Worktracker
  config.around(:each) do |example|
    DB.transaction(:rollback=>:always){example.run}
  end
end
