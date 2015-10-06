require './spec/spec_helper'
require 'selenium-webdriver'

feature "Create for a future print" do		

	before(:all) do
		@driver = Selenium::WebDriver.for(:chrome)
		@driver.navigate.to 'https://artwear.herokuapp.com/'
	    click_button 'Logout'
	    visit 'users/sign_in'
	    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
	    fill_in 'user[password]', :with => 'asdfasdf'	    
	    click_button "Sign in"
	end	

	before(:each) do
		visit 'prints/new'
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