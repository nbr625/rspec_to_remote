require './spec/spec_helper'
require './spec/environments'
require 'selenium-webdriver'
require 'appium_lib'

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

		it "In #{env[:platform]} should create a product" do	
			productNotice = app
				.navigateToAppRoot
				.navigateToAdminPage
				.navigateToNewProductForm
				.inputName
				.inputCreator
				.inputDescription
				.inputImage
				.submitProduct

			notice = productNotice.getNoticeConfimation
			expect(notice).to eq("Product was successfully created.")
			
		end

		it "In #{env[:platform]} should let admin erase a product", "#{env[:tag]}".to_sym do
			deleteNotice = app.deleteProduct
			notice = deleteNotice.getNoticeConfimation
			expect(notice).to eq("Product was successfully destroyed.")
		end

		it "In #{env[:platform]} should redirect admin to the shop page after erasing product" do
			url = app.getUrl
			expect(url).to eq("https://artwear.herokuapp.com/products")
		end

		it "In #{env[:platform]} should raise error if name is left blank", "#{env[:tag]}".to_sym do	
			productAlert = app
				.navigateToAppRoot
				.navigateToAdminPage
				.navigateToNewProductForm
				.inputCreator
				.inputDescription
				.inputImage
				.submitInvalidProduct
			alert = productAlert.getProductAlert
			expect(alert).to eq("Name can\'t be blank")
		end

		it "In #{env[:platform]} should raise an error if creator is left blank", "#{env[:tag]}".to_sym do
			productAlert = app
				.navigateToAppRoot
				.navigateToAdminPage
				.navigateToNewProductForm
				.inputName
				.inputDescription
				.inputImage
				.submitInvalidProduct
			alert = productAlert.getProductAlert
			expect(alert).to eq("Creator can\'t be blank")
		end

		it "In #{env[:platform]} should raise error if description is left blank", "#{env[:tag]}".to_sym do
			productAlert = app
				.navigateToAppRoot
				.navigateToAdminPage
				.navigateToNewProductForm
				.inputName
				.inputImage
				.submitInvalidProduct
			alert = productAlert.getProductAlert
			expect(alert).to eq("Description can\'t be blank")
		end

		after(:all) do
			app.quit
		end
	end

end
