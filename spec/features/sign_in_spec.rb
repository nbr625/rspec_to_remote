require './spec/spec_helper'
require 'selenium-webdriver'
feature "Signing in to ArtWare" do

  before(:all) do
    @driver = Selenium::WebDriver.for(:firefox)
    @driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
  end

  it 'should let user in with a valid account and password' do
    
    @driver.find_element(:id, 'emailfield').send_keys 'murat@breakthrough.com'
    @driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    @driver.find_element(:id, 'submit').click
    notice = @driver.find_element(:id, 'notice').text
    expect(notice).to eq('Signed in successfully.')
  end

  it 'should let user logout' do
    @driver.find_element(:id, 'logoutpath').click
    sleep(inspection_time=5)
    notice = @driver.find_element(:id, 'notice').text
    expect(notice).to eq('Signed out successfully.')

  end


  it 'should not let use in with an invalid account' do
    @driver.navigate.to 'https://artwear.herokuapp.com/users/sign_in'
    @driver.find_element(:id, 'emailfield').send_keys 'invalid@breakthrough.com'
    @driver.find_element(:id, 'passwordfield').send_keys 'asdfasdf'
    @driver.find_element(:id, 'submit').click
    sleep(inspection_time=3)
    alert = @driver.find_element(:id, 'alert').text
    expect(alert).to eq("Invalid email or password.")
  end

  it 'should not let user in with an invalid password' do
    @driver.find_element(:id, 'emailfield').send_keys 'Murat@breakthrough.com'
    @driver.find_element(:id, "passwordfield").send_keys 'incorrect'
    @driver.find_element(:id, "submit").click
    sleep(inspection_time=3)
    alert = @driver.find_element(:id, 'alert').text
    expect(alert).to eq("Invalid email or password.")
  end


  after(:all) do
    @driver.quit
  end

end
