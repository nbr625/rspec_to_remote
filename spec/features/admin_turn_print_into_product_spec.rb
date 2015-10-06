require './spec/spec_helper'

feature "Pledge for a future print" do		

	context 'user is admin' do

		before(:each) do
			click_button 'Logout'
		    visit 'users/sign_in'

		    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
		    fill_in 'user[password]', :with => 'asdfasdf'
		    
		    click_button "Sign in"
		    visit 'prints/23'
		end

		it "I should be allowed to post a review" do
			
			click_button 'Turn into Product'
			expect(page).to have_content("Product was successfully created")
		end
	end
	context "user is not admin" do
		it "should not render the turn into product option" do
			visit 'users/sign_in'

		    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
		    fill_in 'user[password]', :with => 'badabinbadaboom'
		    click_button "Sign in"
		    visit 'prints/23'
		    expect(page).to not_have_content("Turn into Product")
		end

	end

	

end