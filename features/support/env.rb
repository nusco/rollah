$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "rollah"

require 'capybara'
include Capybara::DSL
Capybara.app = Sinatra::Application
