require './spec/spec_helper'
require 'selenium-webdriver'
feature "Signing in to ArtWare" do

  before(:all) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.navigate.to 'https://artwear.herokuapp.com/'
    
  end
  before(:each) do
    click_button 'Logout'
    visit 'users/sign_in'
  end

  it 'should let me in with a valid account' do  
    fill_in 'user[email]', :with => 'Murat@breakthrough.com'
    fill_in 'user[password]', :with => 'asdfasdf'
    click_button "Sign in"
    expect(page).to have_content("Artist of the Month")
  end

  it 'should not let me in with an invalid account' do
    fill_in 'user[email]', :with => 'a@a.com'
    fill_in 'user[password]', :with => 'asdfasdf'
    click_button "Sign in"
    expect(page).to have_content("Invalid email or password")
  end

  after(:all) do
    @driver.quit
  end


end
