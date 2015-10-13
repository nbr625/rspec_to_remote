require './spec/spec_helper'
require 'selenium-webdriver'
require_relative "../../spec/page_objects/home_page"

feature "Sign Up to ArtWare" do

  app = nil

  before(:all) do
    app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
  end

  it 'should let user sign up with valid credential' do 
    signupNotice = app
      .navigateToSignUp
      .inputEmail
      .inputPassword("asdfasdf")
      .inputPwConfirmation("asdfasdf")
      .inputUsername
      .submitSignUpForm
    notice = signupNotice.getNoticeConfimation
    expect(notice).to eq('Welcome! You have signed up successfully.')
  end

  it 'should let user signout after signup' do
    logoutConfirmation = app.logoutUser
    notice = logoutConfirmation.getNoticeConfimation
    expect(notice).to eq('Signed out successfully.')
  end


  it 'should not let user sign up without inputing an email' do 
    signupAlert = app
      .navigateToSignUp
      .inputPassword("asdfasdf")
      .inputPwConfirmation("asdfasdf")
      .inputUsername
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq('Email can\'t be blank')
  end

  it 'should not let user sign up if email is taken' do 

    signupAlert = app
      .navigateToSignUp
      .inputEmail('murat@breakthrough.com')
      .inputPassword("asdfasdf")
      .inputPwConfirmation("asdfasdf")
      .inputUsername
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq('Email has already been taken')
  end

  it 'should not let user sign up with valid credential without inputting a password' do


    signupAlert = app
      .navigateToSignUp
      .inputEmail
      .inputUsername
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq('Password can\'t be blank')
  end

  it 'should not let user sign up without inputing a password confirmation' do  

    signupAlert = app
      .navigateToSignUp
      .inputEmail
      .inputPassword("asdfasdf")
      .inputUsername
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq('Password confirmation doesn\'t match Password')
  end

  it 'should not let user sign up if password confimation does not match' do  

    signupAlert = app
      .navigateToSignUp
      .inputEmail
      .inputPassword("asdfasdf")
      .inputPwConfirmation("incorrect")
      .inputUsername
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq("Password confirmation doesn\'t match Password")
  end

  it 'should not let user sign up if username is taken' do  

    signupAlert = app
      .navigateToSignUp
      .inputEmail
      .inputPassword("asdfasdf")
      .inputPwConfirmation("asdfasdf")
      .inputUsername("nbr625")
      .submitInvalidSignUpForm
    alert = signupAlert.getInvalidSignUpAlert
    expect(alert).to eq('Username has already been taken')
  end



  after(:all) do
    app.quit
  end


end