require './spec/spec_helper'
require 'selenium-webdriver'

feature "Create for a future product" do

	context "user is admin" do
		
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
			visit 'prints/10/subproducts'
		end		

		it "should display price after finalizing pledge" do
			page.select 'Medium', :from => 'Size'
			fill_in 'subproduct[quantity]', :with => 20
			fill_in 'subproduct[price]', :with => 14.99
			click_button "Post Subproduct"
			expect(page).to have_content('14.99')
		end

		it "should display error if size is left blank" do		
			fill_in 'subproduct[quantity]', :with => 20
			fill_in 'subproduct[price]', :with => 14.99
			click_button "Post Subproduct"
			expect(page).to have_content("Size can\'t be blank")
		end

		it "should display error if quantity is left blank" do
			page.select 'Medium', :from => 'Size'		
			fill_in 'subproduct[price]', :with => 14.99
			click_button "Post Subproduct"
			expect(page).to have_content("Quantity can\'t be blank")
		end


		it "should display error if price is left blank" do
			page.select 'Medium', :from => 'Size'
			fill_in 'subproduct[quantity]', :with => 20
			click_button "Post Subproduct"
			expect(page).to have_content("Price can\'t be blank")
		end

	end
	after(:all) do
    	@driver.quit
  	end

end