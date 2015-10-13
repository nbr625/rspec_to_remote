require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'


class AbstractPage

	@@driver = nil

	def initialize(driver)
		@@driver = driver
	end

	def navigateToAppRoot
		@@driver.navigate.to('https://artwear.herokuapp.com')
		sleep(inspection_time=3)
		return HomePage.new(@@driver)
	end

	def login
		@@driver.navigate.to('https://artwear.herokuapp.com/users/sign_in')
		@@driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
		@@driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
		@@driver.find_element(:id, 'submit').click
		sleep(inspection_time=3)
	end

	def navigateToSignIn
		@@driver.find_element(:id, 'signinpage').click
		sleep(inspection_time=3)
		return SignInPage.new(@@driver)
	end

	def navigateToSignUp
		@@driver.navigate.to 'https://artwear.herokuapp.com/users/sign_up'
		sleep(inspection_time=5)
    	@@driver.navigate.refresh
    	sleep(inspection_time=5)
    	return SignUpPage.new(@@driver)	
	end

	def navigateToPrint
    	@@driver.navigate.to 'https://artwear.herokuapp.com/prints/17'
    	sleep(inspection_time=3)
    	return PrintPage.new(@@driver)
    end

	def logoutUser
	    @@driver.find_element(:id, 'logoutpath').click
	    sleep(inspection_time=5)
	    return HomePage.new(@@driver)
    end

    def getNoticeConfimation
    	@@driver.find_element(:id, 'notice').text
    end

    def getAlertConfimation
    	@@driver.find_element(:id, 'alert').text
    end

    def getUrl
    	@@driver.current_url
    end

    def deleteReview                  
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[2]/table[2]/tbody/tr[1]/td[4]/a').click
		sleep(inspection_time=7)
		return AbstractPage.new(@@driver)

	end

    def deleteProduct
		@@driver.find_element(:id, 'eraseproductpath').click
		sleep(inspection_time=3) 
		return ProductIndexPage.new(@@driver)
	end

	def deletePrint
		@@driver.find_element(:id, 'eraseprintpath').click
		sleep(inspection_time=3) 
		return AbstractPage.new(@@driver)
	end

	def quit
		@@driver.quit
	end


end