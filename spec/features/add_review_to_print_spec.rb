require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'

feature "Add reviews" do		

	before(:all) do
		@driver = Selenium::WebDriver.for(:firefox)
		@driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
		@driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
       	@driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    	@driver.find_element(:id, 'submit').click
    	sleep(inspection_time=3)  
	end


	it "should allow user to post review" do
		@driver.navigate.to 'https://artwear.herokuapp.com/prints/15'
		@driver.find_element(:id, 'reviewpath').click
		@driver.navigate.refresh
		sleep(inspection_time=3)  
		@driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/img[2]').click
		comment = Faker::Lorem.paragraph
		@driver.find_element(:id, 'comment').send_keys comment
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3) 
		new_review = @driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[2]/table[1]/tbody/tr/td[2]').text
		expect(new_review).to eq(comment)
		
	end

	it "should allow user to delete their comment and redirect to print" do
		@driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[2]/table[2]/tbody/tr[1]/td[2]/a').click
		sleep(inspection_time=5)
		url = @driver.current_url
		expect(url).to eq("https://artwear.herokuapp.com/prints/15")
	end



	it "should should not allow user to post review if comment is missing" do	
		@driver.find_element(:id, 'reviewpath').click
		@driver.navigate.refresh
		sleep(inspection_time=3)  
		@driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/img[2]').click
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3) 
		alert = @driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/ul/li').text
		expect(alert).to eq("Comment can\'t be blank")
		
	end

	it "should should not allow user to post review if rating is missing" do
		@driver.navigate.to 'https://artwear.herokuapp.com/prints/15'
		@driver.find_element(:id, 'reviewpath').click
		sleep(inspection_time=3)  
		comment = Faker::Lorem.paragraph
		@driver.find_element(:id, 'comment').send_keys comment
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3) 
		alert = @driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/ul/li').text
		expect(alert).to eq("Rating can\'t be blank")
	end



	after(:all) do
    	@driver.quit
  	end
end

