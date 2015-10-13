require './spec/spec_helper'
require 'selenium-webdriver'
require_relative "../../spec/page_objects/home_page"


feature "Signing in to ArtWare" do

  app = nil

  before(:all) do
    app = AbstractPage.new(Selenium::WebDriver.for(:firefox))
  end


  it 'should let user in with a valid account and password' do
    signInConfirmation = app
      .navigateToAppRoot
      .navigateToSignIn
      .fillInEmail('murat@breakthrough.com')
      .fillInPassword('asdfasdf')
      .submitSignInForm
    notice = signInConfirmation.getSignInConfimation
    expect(notice).to eq('Signed in successfully.')
  end

  it 'should let user logout' do
    logoutConfirmation = app.logoutUser
    notice = logoutConfirmation.getLogoutConfimation
    expect(notice).to eq('Signed out successfully.')
  end


  it 'should not let use in with an invalid account' do
    invalidEmailAlert = app
      .navigateToAppRoot
      .navigateToSignIn
      .fillInEmail('invalid@breakthrough.com')
      .fillInPassword('asdfasdf')
      .submitInvalidSignInForm
    alert = invalidEmailAlert.getInvalidSignInAlert
    expect(alert).to eq("Invalid email or password.")
  end

  it 'should not let user in with an invalid password' do
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
