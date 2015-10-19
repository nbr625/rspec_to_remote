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
          
      
		it "In #{env[:platform]} should redirected me after finalizing pledge", "#{env[:name]}".to_sym do
			successPledge = app
				.navigateToPrint
				.navigateToPledge
				.checkAgreement
				.submitPledge
			all_reviews = successPledge.getAllReviewsText
			expect(all_reviews).to eq('All Reviews')
		end

		it "In #{env[:platform]} should not redirect me if checkbox is not is checked", "#{env[:name]}".to_sym do
			pledgeAlert = app
				.navigateToPrint
				.navigateToPledge
				.submitUncheckedPledge
			alert = pledgeAlert.pledgeAlertText
			expect(alert).to eq('Agreement must accept')
		end

		after(:all) do
		    app.quit
		end
	end

end

	
		



		

