require './spec/spec_helper'
require 'selenium-webdriver'

feature "Create for a future print" do		

	before(:all) do
		@driver = Selenium::WebDriver.for(:firefox)
		@driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
		@driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
       	@driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    	@driver.find_element(:id, 'submit').click
    	sleep(inspection_time=3)  
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

	it "should redirected me after finalizing pledge" do
		page.attach_file('Image', 'specs/resources/flare_siren.jpg')
		fill_in 'print[name]', :with => Faker::Name.name
		fill_in 'print[description]', :with => 'Most Beautiful Image'
		click_button "Create Print"
		expect(page).to have_content('Most Beautiful Image')
	end

	it "should raise error if name is left black" do
		
		fill_in 'print[description]', :with => 'Most Beautiful Image'
		click_button "Create Print"
		expect(page).to have_content("Name can't be blank")
	end

	it "should raise error if description is left black" do
		
		fill_in 'print[name]', :with => Faker::Name.name
		click_button "Create Print"
		expect(page).to have_content("Description can't be blank")
	end

	after(:all) do
		@driver.quit
	end

end