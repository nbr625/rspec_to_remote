require './spec/spec_helper'
require 'selenium-webdriver'
require 'faker'
feature "Sign Up to ArtWare" do

  before(:all) do
    @driver = Selenium::WebDriver.for(:firefox)
    sleep(inspection_time=3)  
  end

  before(:each) do
    @driver.navigate.to 'https://artwear.herokuapp.com/users/sign_up'
    @driver.navigate.refresh
    sleep(inspection_time=3)

  end



  it 'should let user sign up with valid credential' do 
    @driver.find_element(:id, 'user_email').send_keys Faker::Internet.email
    @driver.find_element(:id, 'user_password').send_keys 'incorrect'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'incorrect'
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    notice = @driver.find_element(:id, 'notice').text
    expect(notice).to eq('Welcome! You have signed up successfully.')
  end

  it 'should let user sign out after sign up' do
    @driver.find_element(:id, 'logoutpath').click
    sleep(inspection_time=5)
    notice = @driver.find_element(:id, 'notice').text
    expect(notice).to eq('Signed out successfully.')

  end

  it 'should not let user sign up without inputing an email' do 

    @driver.find_element(:id, 'user_password').send_keys 'incorrect'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'incorrect'
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li[1]').text
    expect(alert).to eq('Email can\'t be blank')
  end

  it 'should not let user sign up if email is taken' do 

    @driver.find_element(:id, 'user_email').send_keys 'murat@breakthrough.com'
    @driver.find_element(:id, 'user_password').send_keys 'incorrect'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'incorrect'
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li[1]').text 
    expect(alert).to eq('Email has already been taken')
  end

  it 'should not let user sign up with valid credential without inputting a password' do

    @driver.find_element(:id, 'user_email').send_keys Faker::Internet.email
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li').text
    expect(alert).to eq('Password can\'t be blank')
  end

  it 'should not let user sign up without inputing a password confirmation' do  

    @driver.find_element(:id, 'user_email').send_keys Faker::Internet.email
    @driver.find_element(:id, 'user_password').send_keys 'incorrect' 
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li').text 
    expect(alert).to eq('Password confirmation doesn\'t match Password')
  end

  it 'should not let user sign up if password confimation does not match' do  

    @driver.find_element(:id, 'user_email').send_keys Faker::Internet.email
    @driver.find_element(:id, 'user_password').send_keys 'incorrect'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'incorrect2'
    @driver.find_element(:id, 'user_username').send_keys Faker::Lorem.word
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li').text    
    expect(alert).to eq("Password confirmation doesn\'t match Password")
  end

  it 'should not let user sign up if username is taken' do  

    @driver.find_element(:id, 'user_email').send_keys Faker::Internet.email
    @driver.find_element(:id, 'user_password').send_keys 'incorrect'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'incorrect'
    @driver.find_element(:id, 'user_username').send_keys "nbr625"
    @driver.find_element(:id, 'signupsubmit').click
    sleep(inspection_time=5)
    alert = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/form/div[1]/ul/li').text   
    expect(alert).to eq('Username has already been taken')
  end



  after(:all) do
    @driver.quit
  end


end