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

	it "should create a print" do	
		@driver.find_element(:id, 'new_print').click
		sleep(inspection_time=3)
		# the following file path must be modified in your local environment
		@driver.find_element(:id, 'print_image').send_keys "/Users/eduardokerese/projects/rspec_to_remote/spec/resources/flare_siren.jpg" 
		print_title = Faker::Lorem.word
		@driver.find_element(:id, 'name').send_keys print_title
		@driver.find_element(:id, 'description').send_keys Faker::Lorem.paragraph
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		title = @driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[1]/p[2]').text
		expect(title).to eq(print_title)
		
	end

	it "should let user their erase print" do
		@driver.find_element(:id, 'eraseprintpath').click
		sleep(inspection_time=3) 
		notice = @driver.find_element(:id, 'notice').text
		expect(notice).to eq("Print was successfully destroyed.")
	end

	it "should redirect user to print index after erasing" do
		url = @driver.current_url
		expect(url).to eq("https://artwear.herokuapp.com/prints")
	end

	it "should raise error if name is left black" do	
		@driver.find_element(:id, 'new_print').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'description').send_keys Faker::Lorem.paragraph
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
		expect(alert).to eq("Name can't be blank")
	end

	it "should raise error if description is left black" do
		@driver.navigate.to "https://artwear.herokuapp.com/prints"
		sleep(inspection_time=3)
		@driver.find_element(:id, 'new_print').click
		sleep(inspection_time=3)
		@driver.find_element(:id, 'name').send_keys Faker::Lorem.word
		@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
		expect(alert).to eq("Description can't be blank")
	end

	after(:all) do
		@driver.quit
	end

end