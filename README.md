#rspec_to_Artware.com

This is a blackbox testing framework for Artware.com an artist community/shop webapp.


All tests are integrated in a Page Object Pattern; if one of the xpath's or id's change,
the developer only has to change that value once in the whole framework.


#Warning:
Two page objects need to be changed right away after cloning; The path to the file will be different in each local environment:

page_objects/new_product_page.rb  method = inputImage

and

page_objects/new_print_page.rb  method = inputImage

both need to change their img value to the correct path that your environment takes to the image in the resources folder.

#Tip: 
The simplest way to get the file is to simply drag and drop it into the terminal. Behold the path!


#Caveat:
Sometimes the registration specs will fail when they are run along the bundle of all tests. This is because the assets are not served in time. This seems to symptomatic of a deeper problem issue with the turbolinks. This is definitely something that should be looked into a debugged with a vengeance, but at the time I wanted focus on the tests themselves. I will revisit this issue. For now, the tests run fine when the registration spec is run by itself.


#Setup
bundle install

#Running tests
bundle exec rspec --format documentation

#Running tests with an output file
bundle exec rspec --format documentation --out rspec.txt

For the copy paste enthusiast

#Spec Terminal Commands
rspec spec/features/add_print_spec.rb

rspec spec/features/add_review_to_print_spec.rb

rspec spec/features/admin_add_new_product_spec.rb

rspec spec/features/flag_print_spec.rb

rspec spec/features/pledge_for_print_spec.rb

rspec spec/features/registration_spec.rb

rspec spec/features/sign_in_spec.rb

Happy testing!