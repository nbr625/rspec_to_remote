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

	before(:each) do
		@driver.navigate.to 'https://artwear.herokuapp.com/prints/17'
	end

	it "should redirected me after finalizing pledge" do

		@driver.find_element(:id, 'pledgepath').click
		sleep(inspection_time=3) 
		@driver.find_element(:id, 'agreement').click
		@driver.find_element(:id, 'submit').click
		sleep(inspection_time=3)  
		all_reviews = @driver.find_element(:id, 'allreviews').text
		expect(all_reviews).to eq('All Reviews')
		
	end

	it "should not redirect me if checkbox is not is checked" do
		@driver.find_element(:id, 'pledgepath').click
		sleep(inspection_time=3) 
		@driver.find_element(:id, 'submit').click
		sleep(inspection_time=3)  
		all_reviews = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/li').text
		expect(all_reviews).to eq('Agreement must accept')
	end

	after(:all) do
	    @driver.quit
	end

end

	
		



		

