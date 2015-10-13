require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"

feature "Create for a future print" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end

	it "should create a print" do
		print_title = Faker::Lorem.word
		printTitle = app 
			.navigateToAppRoot
			.navigateToNewPrint
			.inputImage
			.inputName(print_title)
			.inputDescription
			.submitPrint

		title = printTitle.getPrintTitle
		expect(title).to eq(print_title)
		
	end

	it "should let user their erase print" do	
		notice = app
			.deletePrint
			.getNoticeConfimation

		expect(notice).to eq("Print was successfully destroyed.")
	end

	it "should redirect user to print index after erasing" do
		url = app
			.getUrl

		expect(url).to eq("https://artwear.herokuapp.com/prints")
	end

	it "should raise error if name is left black" do	
		printAlert = app 
			.navigateToAppRoot
			.navigateToNewPrint
			.inputImage
			.inputDescription
			.submitInvalidPrint
		alert = printAlert.getPrintAlert
		expect(alert).to eq("Name can't be blank")
	end

	it "should raise error if description is left black" do
		printAlert = app 
			.navigateToAppRoot
			.navigateToNewPrint
			.inputImage
			.inputName
			.submitInvalidPrint
		alert = printAlert.getPrintAlert
		expect(alert).to eq("Description can't be blank")
	end

	after(:all) do
		app.quit
	end

end