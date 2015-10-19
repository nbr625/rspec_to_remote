require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'
require 'appium_lib'
require './spec/environments'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"

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

		it "In #{env[:platform]} should create a print", "#{env[:tag]}".to_sym do
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

		it "In #{env[:platform]} should let user delete their own print", "#{env[:tag]}".to_sym do	
			notice = app
				.deletePrint
				.getNoticeConfimation

			expect(notice).to eq("Print was successfully destroyed.")
		end

		it "In #{env[:platform]} should redirect user to print index after erasing", "#{env[:tag]}".to_sym do
			url = app
				.getUrl

			expect(url).to eq("https://artwear.herokuapp.com/prints")
		end

		it "In #{env[:platform]} should raise error if name is left blank", "#{env[:tag]}".to_sym do	
			printAlert = app 
				.navigateToAppRoot
				.navigateToNewPrint
				.inputImage
				.inputDescription
				.submitInvalidPrint
			alert = printAlert.getPrintAlert
			expect(alert).to eq("Name can't be blank")
		end

		it "In #{env[:platform]} should raise error if description is left black", "#{env[:tag]}".to_sym do
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

end