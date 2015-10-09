require './spec/spec_helper'
require 'selenium-webdriver'
feature "Signing in to ArtWare" do

  before(:all) do
    @driver = :chrome
  end

  after(:all) do
    @driver.quit
  end

  it 'should let me in with a valid account' do
    @driver.get 'https://artwear.herokuapp.com/'
    find("#signin").click  
    fill_in 'Email :', :with => 'Murat@breakthrough.com'
    fill_in 'Password :', :with => 'asdfasdf'
    find("#signin").click
    expect(page).to have_content("Artist of the Month")
  end

  it 'should not let me in with an invalid account' do
    @driver.get 'https://artwear.herokuapp.com/'
    fill_in 'Email :', :with => 'a@a.com'
    fill_in 'Password :', :with => 'asdfasdf'
    find("#signin").click
    expect(page).to have_content("Invalid email or password")
  end




end
