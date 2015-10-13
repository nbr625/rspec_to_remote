require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/new_print_page"
require_relative "../../spec/page_objects/pledge_page"
require_relative "../../spec/page_objects/new_review_page"



class PrintPage < AbstractPage

	def navigateToPledge
		@@driver.find_element(:id, 'pledgepath').click
		sleep(inspection_time=3) 
		return PledgePage.new(@@driver)
	end

	def navigateToReview
		@@driver.find_element(:id, 'reviewpath').click
		@@driver.navigate.refresh
		sleep(inspection_time=3) 
		return NewReviewPage.new(@@driver)
	end

	def getAllReviewsText
		@@driver.find_element(:id, 'allreviews').text
	end

	def getNewReview
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[2]/table[1]/tbody/tr/td[2]').text
	end

	def flagPrint
		@@driver.find_element(:id, 'flagpath').click
		sleep(inspection_time=3)
		return PrintPage.new(@@driver)
	end

	def getPrintTitle
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/div/div[1]/p[2]').text
	end



end











