require './spec/spec_helper'
require 'selenium-webdriver'

require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/abstract_page"


feature "Create for a future print" do		

	app = nil

	before(:all) do
	  	app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
	  	app.login
	end

	it "should create a product" do	
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

	it "should let admin erase a product" do
		deleteNotice = app.deleteProduct
		notice = deleteNotice.getNoticeConfimation
		expect(notice).to eq("Product was successfully destroyed.")
	end

	it "should redirect admin to the shop page after erasing product" do
		url = app.getUrl
		expect(url).to eq("https://artwear.herokuapp.com/products")
	end

	it "should raise error if name is left blank" do	
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

	it "should raise an error if creator is left blank" do
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

	it "should raise error if description is left blank" do
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
