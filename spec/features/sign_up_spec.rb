require './spec/spec_helper'
require 'selenium-webdriver'
feature "Sign Up to ArtWare" do

  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.navigate.to 'https://artwear.herokuapp.com/'
    click_button 'Logout'
  end

  it 'should let me sign up with valid credential' do  
    visit 'users/sign_up'
    fill_in 'user[email]', :with => 'nbr625@breakthrough.com'
    fill_in 'user[password]', :with => 'asdfasdf'
    fill_in 'user[password confirmation]', :with => 'asdfasdf'
    fill_in 'user[username]', :with => 'user1'
    click_button "Sign up"
    expect(page).to have_content("New Prints!")
  end

  it 'should not let me sign_up with an invalid account' do
    visit 'users/sign_up'
    fill_in 'user[email]', :with => 'a@a.com'
    fill_in 'user[password]', :with => 'asdfasdf'
    fill_in 'user[password confirmation]', :with => 'asdfasdf'
    fill_in 'user[username]', :with => 'user1'
    click_button "Sign up"
    expect(page).to have_content("Invalid email or password")
  end

  after(:all) do
    @driver.quit
  end


end