require './spec/spec_helper'
require 'selenium-webdriver'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/print_page"

feature "Add reviews" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end


	it "should allow user to post review" do
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


	it "should allow user to delete their comment and redirect to print" do
		url = app
			.deleteReview
			.getUrl

		expect(url).to eq("https://artwear.herokuapp.com/prints/17")
	end



	it "should should not allow user to post review if comment is missing" do	
		reviewMessage = app
			.navigateToPrint 
			.navigateToReview
			.inputRating
			.submitInvalidReview

		alert = reviewMessage.reviewAlert
		expect(alert).to eq("Comment can\'t be blank")		
	end

	it "should should not allow user to post review if rating is missing" do
		reviewMessage = app
			.navigateToPrint 
			.navigateToReview
			.inputComment
			.submitInvalidReview

		alert = reviewMessage.reviewAlert
		expect(alert).to eq("Rating can\'t be blank")
	end


	after(:all) do
    	@driver.quit
  	end

end

