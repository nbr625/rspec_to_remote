require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/home_page"


class SignUpPage < AbstractPage


    def initialize(driver)
    	super(driver)
    end

	def inputEmail(email = Faker::Internet.email)
		@@driver.find_element(:id, 'user_email').send_keys email
		return SignUpPage.new(@@driver)
	end


	def inputUsername(username = Faker::Lorem.word)
		@@driver.find_element(:id, 'user_username').send_keys username
		return SignUpPage.new(@@driver)
	end


	def inputPassword(password)
		@@driver.find_element(:id, 'user_password').send_keys password
		return SignUpPage.new(@@driver)
	end


	def inputPwConfirmation(confirmation)
		@@driver.find_element(:id, 'user_password_confirmation').send_keys confirmation
		return SignUpPage.new(@@driver)
	end


	def submitSignUpForm
		@@driver.find_element(:id, 'signupsubmit').click
		sleep(inspection_time=5)
		return HomePage.new(@@driver)
	end

	def submitInvalidSignUpForm
		@@driver.find_element(:id, 'signupsubmit').click
		sleep(inspection_time=5)
		return SignUpPage.new(@@driver)
	end

	def getInvalidSignUpAlert
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li[1]').text
	end


end




















