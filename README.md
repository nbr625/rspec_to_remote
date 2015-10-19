#rspec_to_Artware.com

This is a blackbox testing framework for Artware.com an artist community/shop webapp.


All tests are integrated in a Page Object Pattern; if one of the xpath's or id's change,
the developer only has to change that value once in the whole framework.

Moreover, it is fully integrated with Appium mobile functionality for andriod and ios. These tests are dynamically created through one single spec file. The user has the option to filter all other platforms by passing the tag corresponding to each set of tests.


#Caveat:
Sometimes the registration specs will fail when they are run along the bundle of all tests. This is because the assets are not served in time. This seems to symptomatic of a deeper problem issue with the turbolinks. This is definitely something that should be looked into a debugged with a vengeance, but at the time I wanted focus on the tests themselves. I will revisit this issue. For now, the tests run fine when the registration spec is run by itself.


#Setup
bundle install

#Running tests
bundle exec rspec --format documentation



#Running tests with an output file
bundle exec rspec --format documentation --out rspec.txt


#Spec Terminal Commands


rspec spec/features/add_print_spec.rb 

rspec spec/features/add_review_to_print_spec.rb

rspec spec/features/admin_add_new_product_spec.rb

rspec spec/features/flag_print_spec.rb

rspec spec/features/pledge_for_print_spec.rb

rspec spec/features/registration_spec.rb

rspec spec/features/sign_in_spec.rb

#tags

Desktop:      deskt

Andriod:      andr

IOS:          ios


As example lets use the add_print_spec.rb in all three platforms.

rspec spec/features/add_print_spec.rb --tag deskt

rspec spec/features/add_print_spec.rb --tag andr

rspec spec/features/add_print_spec.rb --tag ios


this can also be done with all tests 


bundle exec rspec --tag deskt


Happy testing!