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

	it "I should be allowed to post a review" do
		click_button 'Review'
		page.select '3', :from => 'review[rating]'
		fill_in 'review[comment]', :with => 'I think it could use some improvement'
		click_button 'Create Review'
		expect(page).to have_content("I think it could use some improvement")
	end

	it "should not allow me to post review if comment is not included" do
		click_button 'Review'
		page.select '3', :from => 'review[rating]'		
		click_button 'Create Review'
		expect(page).to have_content("Comment can\'t be blank")
	end

	it "should not allow me to post review if comment is not included" do
		click_button 'Review'		
		fill_in 'review[comment]', :with => 'I think it could use some improvement'
		click_button 'Create Review'
		expect(page).to have_content("Comment can\'t be blank")
	end

end