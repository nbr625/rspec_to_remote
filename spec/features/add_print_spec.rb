require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'
require 'appium_lib'
require './spec/environments'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"

feature "Create for a future print" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end

	it "In #{env[:platform]} should create a print" do
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

	it "In #{env[:platform]} should let user delete their own print", "#{env[:name]}".to_sym do	
		notice = app
			.deletePrint
			.getNoticeConfimation

		expect(notice).to eq("Print was successfully destroyed.")
	end

	it "In #{env[:platform]} should redirect user to print index after erasing", "#{env[:name]}".to_sym do
		url = app
			.getUrl

		expect(url).to eq("https://artwear.herokuapp.com/prints")
	end

	it "In #{env[:platform]} should raise error if name is left blank", "#{env[:name]}".to_sym do	
		printAlert = app 
			.navigateToAppRoot
			.navigateToNewPrint
			.inputImage
			.inputDescription
			.submitInvalidPrint
		alert = printAlert.getPrintAlert
		expect(alert).to eq("Name can't be blank")
	end

	it "In #{env[:platform]} should raise error if description is left black", "#{env[:name]}".to_sym do
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