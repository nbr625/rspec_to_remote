require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'

feature "Create for a future print" do		

	before(:all) do
		@driver = Selenium::WebDriver.for(:firefox)
		@driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
		@driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
       	@driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    	@driver.find_element(:id, 'submit').click
    	sleep(inspection_time=3)  
	end	

	it "should create a product" do	
		@driver.find_element(:id, 'adminpage').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'addnewproductpath').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'name').send_keys Faker::Lorem.word
		@driver.find_element(:id, 'creator').send_keys "Nicolas Lovewell"
		@driver.find_element(:id, 'description').send_keys Faker::Lorem.paragraph
		# file path must be changed to match local environment
		@driver.find_element(:id, 'image').send_keys "/Users/eduardokerese/projects/rspec_to_remote/spec/resources/flare_siren.jpg"
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		notice = @driver.find_element(:id, 'notice').text
		expect(notice).to eq("Product was successfully created.")
		
	end

	it "should let admin their erase product" do
		@driver.find_element(:id, 'eraseproductpath').click
		sleep(inspection_time=3) 
		notice = @driver.find_element(:id, 'notice').text
		expect(notice).to eq("Product was successfully destroyed.")
	end

	it "should redirect admin to shop after erasing product" do
		url = @driver.current_url
		expect(url).to eq("https://artwear.herokuapp.com/products")
	end

	it "should raise error if name is left black" do	
		@driver.find_element(:id, 'adminpage').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'addnewproductpath').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'creator').send_keys "Nicolas Lovewell"
		@driver.find_element(:id, 'description').send_keys Faker::Lorem.paragraph
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
		expect(alert).to eq("Name can\'t be blank")
	end

	it "should raise error if creator is left black" do
		@driver.find_element(:id, 'adminpage').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'addnewproductpath').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'name').send_keys Faker::Lorem.word
		@driver.find_element(:id, 'description').send_keys Faker::Lorem.paragraph
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		notice = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
		expect(notice).to eq("Creator can\'t be blank")
	end

	it "should raise error if description is left black" do
		@driver.find_element(:id, 'adminpage').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'addnewproductpath').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'name').send_keys Faker::Lorem.word
		@driver.find_element(:id, 'creator').send_keys "Nicolas Lovewell"
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		notice = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
		expect(notice).to eq("Description can\'t be blank")
	end

	after(:all) do
		@driver.quit
	end

end
