require 'capybara/rspec'
require 'rubygems'
require 'bundler/setup'

Capybara.default_driver = :selenium
Capybara.app_host = 'http://artwear.herokuapp.com/'
Capybara.run_server = false

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end