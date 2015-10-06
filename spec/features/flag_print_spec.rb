require './spec/spec_helper'

feature "Pledge for a future print" do		

	before(:each) do
		sign_in	create(:user)
		@print = create(:print)
		visit "/prints/{print.id}"
	end	


	

	it "shoult redirected me after finalizing pledge" do
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