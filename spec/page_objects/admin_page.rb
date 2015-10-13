require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/home_page"
require_relative "../../spec/page_objects/new_product_page"



class AdminPage < AbstractPage

	def navigateToNewProductForm
		@@driver.find_element(:id, 'addnewproductpath').click
		sleep(inspection_time=3)
		return NewProductPage.new(@@driver)
	end

end


