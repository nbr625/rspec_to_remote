require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/print_page"


class NewPrintPage < AbstractPage

	
	def inputImage(img = (File.absolute_path "./spec/resources/flare_siren.jpg"))
		@@driver.find_element(:id, 'print_image').send_keys img
		return NewPrintPage.new(@@driver)
	end
	
	def inputName(name = Faker::Lorem.word)
		@@driver.find_element(:id, 'name').send_keys name
		return NewPrintPage.new(@@driver)
	end

	def inputDescription(description = Faker::Lorem.paragraph)
		@@driver.find_element(:id, 'description').send_keys description
		return NewPrintPage.new(@@driver)
	end

	def submitPrint
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		return PrintPage.new(@@driver)
	end

	def submitInvalidPrint
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		return NewPrintPage.new(@@driver)
	end

	def getPrintAlert
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
	end



end