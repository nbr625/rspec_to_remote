require './spec/spec_helper'
require 'selenium-webdriver'
require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/print_page"


feature "Pledge for a future print" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end
          
      
	it "should redirected me after finalizing pledge" do
		successPledge = app
			.navigateToPrint
			.navigateToPledge
			.checkAgreement
			.submitPledge
		all_reviews = successPledge.getAllReviewsText
		expect(all_reviews).to eq('All Reviews')
	end

	it "should not redirect me if checkbox is not is checked" do
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

	
		



		

