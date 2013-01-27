$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "diceroller"

require 'capybara'
include Capybara::DSL
Capybara.app = Sinatra::Application
