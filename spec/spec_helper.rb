require "bundler/setup"

$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "rollah"

require "timecop"
RSpec.configure do |c|
  c.after do
    Timecop.return
  end
end

require "turnip/capybara"
#ENV['RACK_ENV'] = 'test'  # is this useful?
Capybara.app = Sinatra::Application.new
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new app, \
    redirect_limit: 15,
    follow_redirects: true,
    respect_data_method: true
end

Dir.glob(File.expand_path("./**/*steps.rb", File.dirname(__FILE__))) { |f| require f }