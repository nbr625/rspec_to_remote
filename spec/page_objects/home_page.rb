require_relative "../../spec/page_objects/abstract_page"
require_relative "../../spec/page_objects/sign_in_page"
require_relative "../../spec/page_objects/sign_up_page"
require_relative "../../spec/page_objects/admin_page"
require_relative "../../spec/page_objects/new_print_page"

class HomePage < AbstractPage

	def initialize(driver)
		super(driver)
	end

    def navigateToPrint
    	@@driver.navigate.to 'https://artwear.herokuapp.com/prints/17'
    	return PrintPage.new(@@driver)
    end

    def navigateToAdminPage
		@@driver.find_element(:id, 'adminpage').click
		sleep(inspection_time=3)
		return AdminPage.new(@@driver)
    end

    def navigateToNewPrint
        @@driver.find_element(:id, 'new_print').click
        sleep(inspection_time=3)
        return NewPrintPage.new(@@driver)
    end




end