require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/print_page"

class PledgePage < AbstractPage


	def checkAgreement
		@@driver.find_element(:id, 'agreement').click
		return PledgePage.new(@@driver)
	end


	def submitPledge
		@@driver.find_element(:id, 'submit').click
		return PrintPage.new(@@driver)
	end


	def submitUncheckedPledge
		@@driver.find_element(:id, 'submit').click
		sleep(inspection_time=3)  
		return PledgePage.new(@@driver)
	end

	def pledgeAlertText
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/li').text
	end


end