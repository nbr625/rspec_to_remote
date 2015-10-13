require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/sign_in_page"

class HomePage < AbstractPage

	def initialize(driver)
		super(driver)
	end



	def getSignInConfimation
    	@@driver.find_element(:id, 'notice').text
    end



    def getLogoutConfimation
    	@@driver.find_element(:id, 'notice').text
    end

end