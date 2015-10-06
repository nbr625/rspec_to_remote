require './spec/spec_helper'
require 'selenium-webdriver'

feature "Create for a future product" do
	
	before(:all) do
		@driver = Selenium::WebDriver.for(:chrome)
		@driver.navigate.to 'https://artwear.herokuapp.com/'
		click_button 'Logout'
	    visit 'users/sign_in'

	    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
	    fill_in 'user[password]', :with => 'asdfasdf'	    
	    click_button "Sign in"
	    visit 'prints/16'
	end	

	it "can add products to the cart" do
		fill_in 'subproduct[quantity]', :with => 2
		click_button "Add to Cart"
		expect(page).to have_content('2 Items in Cart')
	end

	after(:all) do
    	@driver.quit
  	end

end