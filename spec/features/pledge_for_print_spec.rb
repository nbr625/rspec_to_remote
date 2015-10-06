require './spec/spec_helper'

feature "Pledge for a future print" do		

	before(:each) do
		click_button 'Logout'
	    visit 'users/sign_in'

	    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
	    fill_in 'user[password]', :with => 'asdfasdf'
	    
	    click_button "Sign in"
	    visit 'prints/17'
	end	


	

	it "should redirected me after finalizing pledge" do
		click_button "Pledge"
		page.check "I agree"
		click_button "Support"
		expect(page).to have_content("All Reviews")
	end

	it "should not redirect me if checkbox is not is checked" do
		describe "redirected after finalizing pledge"
		click_button "Pledge"
		click_button "Support"
		expect(page).to have_content("must accept")
	end
end

	
		



		
