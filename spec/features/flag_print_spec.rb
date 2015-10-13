require './spec/spec_helper'
require 'selenium-webdriver'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/print_page"

feature "Flag a print" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end


	it "should allow user to flag print" do
		app
			.navigateToPrint
			.flagPrint 
			
		notice = app.getNoticeConfimation
		expect(notice).to eq('Print was successfully flagged.')
		
	end

	after(:all) do
    	app.quit
  	end
end