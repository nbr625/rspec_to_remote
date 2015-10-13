require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/new_product_page"
require_relative "../../spec/page_objects/product_index_page"


class ProductPage < AbstractPage

	def deleteProduct
		@@driver.find_element(:id, 'eraseproductpath').click
		sleep(inspection_time=3) 
		return ProductIndexPage.new(@@driver)
	end

end