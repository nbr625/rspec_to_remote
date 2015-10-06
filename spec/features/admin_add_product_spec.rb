require './spec/spec_helper'

feature "Create for a future product" do

	context "user is admin"
		before(:each) do

		    click_button 'Logout'

		    visit 'users/sign_in'

		    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
		    fill_in 'user[password]', :with => 'asdfasdf'	    
		    click_button "Sign in"
		    visit 'admin/main'
			click_button 'Add New Product'
		end	


		

		it "should redirected me after finalizing pledge" do
			page.attach_file('Image', 'specs/resources/flare_siren.jpg')
			fill_in 'product[name]', :with => Faker::Name.name
			fill_in 'product[creator]', :with => 'Nicolas Lovewell'
			fill_in 'product[description]', :with => 'Most Beautiful Image'
			click_button "Post Product"
			expect(page).to have_content('Nicolas Lovewell')
		end

		it "should display error if name is left blank" do

			page.attach_file('Image', 'specs/resources/flare_siren.jpg')		
			fill_in 'product[creator]', :with => 'Nicolas Lovewell'
			fill_in 'product[description]', :with => 'Most Beautiful Image'
			click_button "Post Product"
			expect(page).to have_content("Name can\'t be blank")
		end

		it "should display error if creator is left blank" do

			page.attach_file('Image', 'specs/resources/flare_siren.jpg')
			fill_in 'product[name]', :with => Faker::Name.name		
			fill_in 'product[description]', :with => 'Most Beautiful Image'
			click_button "Post Product"
			expect(page).to have_content("Creator can\'t be blank")
		end


		it "should display error if creator is left blank" do

			page.attach_file('Image', 'specs/resources/flare_siren.jpg')
			fill_in 'product[name]', :with => Faker::Name.name	
			fill_in 'product[creator]', :with => 'Nicolas Lovewell'
			click_button "Post Product"
			expect(page).to have_content("Description can\'t be blank")
		end

	end


end