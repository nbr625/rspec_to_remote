require './spec/spec_helper'
require 'selenium-webdriver'


class AbstractPage

	@@driver = nil

	def initialize(driver)
		@@driver = driver
	end

	def navigateToAppRoot
		@@driver.navigate.to('https://artwear.herokuapp.com')
		return HomePage.new(@@driver)
	end

	def navigateToSignIn
		@@driver.find_element(:id, 'signinpage').click
		return SignInPage.new(@@driver)
	end

	def logoutUser
	    @@driver.find_element(:id, 'logoutpath').click
	    sleep(inspection_time=5)
	    return HomePage.new(@@driver)
    end

	def quit
		@@driver.quit
	end


end