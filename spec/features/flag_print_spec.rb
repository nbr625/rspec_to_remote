require './spec/spec_helper'
require './spec/environments'
require 'selenium-webdriver'
require 'appium_lib'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/print_page"

@environments.each do |env|

    feature "Signing in to ArtWare" do

      	app = nil

    	if env[:type] == "computer"

      		before(:all) do
        		app = AbstractPage.new(Selenium::WebDriver.for(("#{env[:browser]}").to_sym))
      		end

    	elsif env[:type] == "mobile"

      		before(:all) do
        		appium_driver = Appium::Driver.new(env[:desired_caps])
        		app = appium_driver.start_driver
      		end

    	end


		it "In #{env[:platform]} should allow user to flag print", "#{env[:tag]}".to_sym do
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
end