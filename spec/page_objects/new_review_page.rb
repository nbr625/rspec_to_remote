require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/print_page"

class NewReviewPage < AbstractPage


	def inputRating
		@@driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/img[2]').click
		return NewReviewPage.new(@@driver)
	end

	def inputComment(comment = Faker::Lorem.paragraph)
		@@driver.find_element(:id, 'comment').send_keys comment
		return NewReviewPage.new(@@driver)
	end

	def submitReview
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3) 
		return PrintPage.new(@@driver)
	end

	def submitInvalidReview
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=5) 
		return NewReviewPage.new(@@driver)
	end

	def reviewAlert           
		@@driver.find_element(:xpath, '/html/body/div[2]/form/div[1]/ul/li').text
	end


end
