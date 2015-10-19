require './spec/spec_helper'
require './spec/environments'
require 'selenium-webdriver'
require 'appium_lib'
require 'faker'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/print_page"

@environments.each do |env|

    feature "Signing in to ArtWare" do

      	app = nil

    	if env[:type] == "computer"

      		before(:all) do
        		app = AbstractPage.new(Selenium::WebDriver.for(("#{env[:browser]}").to_sym))
      		end

    	elsif env[:type] == "mobile"

      		before(:all) do
        		appium_driver = Appium::Driver.new(env[:desired_caps])
        		app = appium_driver.start_driver
      		end

    	end


		it "In #{env[:platform]} should allow user to post review" do
			comment = Faker::Lorem.paragraph
			newReview = app
				.navigateToPrint 
				.navigateToReview
				.inputRating
				.inputComment(comment)
				.submitReview

			new_review = newReview.getNewReview
			expect(new_review).to eq(comment)
			
		end


		it "In #{env[:platform]} should allow user to delete their comment and redirect to print", "#{env[:name]}".to_sym do
			url = app
				.deleteReview
				.getUrl

			expect(url).to eq("https://artwear.herokuapp.com/prints/17")
		end



		it "In #{env[:platform]} should not allow user to post review if comment is missing", "#{env[:name]}".to_sym do	
			reviewMessage = app
				.navigateToPrint 
				.navigateToReview
				.inputRating
				.submitInvalidReview

			alert = reviewMessage.reviewAlert
			expect(alert).to eq("Comment can\'t be blank")		
		end

		it "In #{env[:platform]} should not allow user to post review if rating is missing", "#{env[:name]}".to_sym do
			reviewMessage = app
				.navigateToPrint 
				.navigateToReview
				.inputComment
				.submitInvalidReview

			alert = reviewMessage.reviewAlert
			expect(alert).to eq("Rating can\'t be blank")
		end


		after(:all) do
	    	app.quit
	  	end
	end

end

