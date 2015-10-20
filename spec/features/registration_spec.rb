require './spec/spec_helper'
require './spec/environments'
require 'selenium-webdriver'
require 'appium_lib'
require_relative "../../spec/page_objects/home_page"



@environments.each do |env|

  feature "Signing in to ArtWare" do

    app = nil

    if env[:type] == "computer"

      before(:all) do
        app = AbstractPage.new(Selenium::WebDriver.for(("#{env[:browser]}").to_sym))
      end

    elsif env[:type] == "mobile"

          before(:all) do
            app = Appium::Driver.new(env[:desired_caps]).start_driver
            Appium.promote_appium_methods Object
          end

    end

    it "In #{env[:platform]} should let user sign up with valid credentials", "#{env[:tag]}".to_sym do 
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

    it "In #{env[:platform]} should let user signout after signup", "#{env[:tag]}".to_sym do
      logoutConfirmation = app.logoutUser

      notice = logoutConfirmation.getNoticeConfimation
      expect(notice).to eq('Signed out successfully.')
    end


    it "In #{env[:platform]} should not let user sign up without inputing an email", "#{env[:tag]}".to_sym do 
      signupAlert = app
        .navigateToSignUp
        .inputPassword("asdfasdf")
        .inputPwConfirmation("asdfasdf")
        .inputUsername
        .submitInvalidSignUpForm

      alert = signupAlert.getInvalidSignUpAlert
      expect(alert).to eq('Email can\'t be blank')
    end

    it "In #{env[:platform]} should not let user sign up if email is taken", "#{env[:tag]}".to_sym do 

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

    it "In #{env[:platform]} should not let user sign up with valid credential without inputting a password", "#{env[:tag]}".to_sym do
      signupAlert = app
        .navigateToSignUp
        .inputEmail
        .inputUsername
        .submitInvalidSignUpForm

      alert = signupAlert.getInvalidSignUpAlert
      expect(alert).to eq('Password can\'t be blank')
    end

    it "In #{env[:platform]} should not let user sign up without inputing a password confirmation", "#{env[:tag]}".to_sym do  

      signupAlert = app
        .navigateToSignUp
        .inputEmail
        .inputPassword("asdfasdf")
        .inputUsername
        .submitInvalidSignUpForm

      alert = signupAlert.getInvalidSignUpAlert
      expect(alert).to eq('Password confirmation doesn\'t match Password')
    end

    it "In #{env[:platform]} should not let user sign up if password confimation does not match", "#{env[:tag]}".to_sym do  

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

    it "In #{env[:platform]} should not let user sign up if username is taken", "#{env[:tag]}".to_sym do  

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
end