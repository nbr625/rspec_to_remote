require './spec/spec_helper'
require 'selenium-webdriver'

feature "Pledge for a future print" do		

	before(:all) do
		@driver = Selenium::WebDriver.for(:firefox)
		@driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
		@driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
       	@driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    	@driver.find_element(:id, 'submit').click
    	sleep(inspection_time=3)  
	end	


	it "should allow user to flag print" do
		@driver.navigate.to 'https://artwear.herokuapp.com/prints/17'
		@driver.find_element(:id, 'flagpath').click
		sleep(inspection_time=3)  
		notice = @driver.find_element(:id, 'notice').text
		expect(notice).to eq('Print was successfully flagged.')
		
	end

	after(:all) do
    	@driver.quit
  	end
end