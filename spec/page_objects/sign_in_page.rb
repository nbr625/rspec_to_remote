require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/home_page"

class SignInPage < AbstractPage


    def initialize(driver)
    	super(driver)
    end

    def fillInEmail(email)
    	@@driver.find_element(:id, 'emailfield').send_keys email
    	return SignInPage.new(@@driver)
    end

    def fillInPassword(password)
    	@@driver.find_element(:id, 'passwordfield').send_keys password
    	return SignInPage.new(@@driver)
    end

    def submitSignInForm
    	@@driver.find_element(:id, 'submit').click
    	return HomePage.new(@@driver)
    	sleep(inspection_time=3)
    end

    def submitInvalidSignInForm
    	@@driver.find_element(:id, 'submit').click
    	return SignInPage.new(@@driver)
    	sleep(inspection_time=3)
    end

    def getInvalidSignInAlert
    	@@driver.find_element(:id, 'alert').text
    end



end