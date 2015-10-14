require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/admin_page"
require_relative "../../spec/page_objects/product_page"

class NewProductPage < AbstractPage

	def inputName(name = Faker::Lorem.word)
		@@driver.find_element(:id, 'name').send_keys name
		return NewProductPage.new(@@driver)
	end

	def inputCreator(creator = "Nicolas Lovewell")
		@@driver.find_element(:id, 'creator').send_keys creator
		return NewProductPage.new(@@driver)
	end

	def inputDescription(description = Faker::Lorem.paragraph)
		@@driver.find_element(:id, 'description').send_keys description
		return NewProductPage.new(@@driver)
	end

	
	def inputImage(img = (File.absolute_path "./spec/resources/flare_siren.jpg"))
		@@driver.find_element(:id, 'image').send_keys img
		return NewProductPage.new(@@driver)
	end

	def submitProduct
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		return ProductPage.new(@@driver)
	end

	def submitInvalidProduct
		@@driver.find_element(:name, 'commit').click
		sleep(inspection_time=3)
		return NewProductPage.new(@@driver)
	end

	def getProductAlert
		@@driver.find_element(:xpath, '/html/body/div[2]/div/div/form/div[1]/ul/li').text
	end


end