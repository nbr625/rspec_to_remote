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
        appium_driver = Appium::Driver.new(env[:desired_caps])
        app = appium_driver.start_driver
      end

    end



    it "In #{env[:platform]} app should let user in with a valid account and password", "#{env[:tag]}".to_sym do
      signInConfirmation = app
        .navigateToAppRoot
        .navigateToSignIn
        .fillInEmail('murat@breakthrough.com')
        .fillInPassword('asdfasdf')
        .submitSignInForm

      notice = signInConfirmation.getNoticeConfimation
      expect(notice).to eq('Signed in successfully.')
    end

    it "In #{env[:platform]} app should let user logout" do
      logoutConfirmation = app.logoutUser

      notice = logoutConfirmation.getNoticeConfimation
      expect(notice).to eq('Signed out successfully.')
    end


    it "In #{env[:platform]} app should not let use in with an invalid account", "#{env[:tag]}".to_sym do
      invalidEmailAlert = app
        .navigateToAppRoot
        .navigateToSignIn
        .fillInEmail('invalid@breakthrough.com')
        .fillInPassword('asdfasdf')
        .submitInvalidSignInForm

      alert = invalidEmailAlert.getInvalidSignInAlert
      expect(alert).to eq("Invalid email or password.")
    end

    it "In #{env[:platform]} app should not let user in with an invalid password", "#{env[:tag]}".to_sym do
      invalidEmailAlert = app
        .navigateToAppRoot
        .navigateToSignIn
        .fillInEmail('murat@breakthrough.com')
        .fillInPassword('incorrect')
        .submitInvalidSignInForm

      alert = invalidEmailAlert.getInvalidSignInAlert
      expect(alert).to eq("Invalid email or password.")
    end


    after(:all) do
      app.quit
    end

  end
end
